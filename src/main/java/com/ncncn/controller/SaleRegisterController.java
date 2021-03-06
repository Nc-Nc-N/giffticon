package com.ncncn.controller;


import com.ncncn.domain.BrandVO;
import com.ncncn.domain.GifticonVO;
import com.ncncn.domain.ProductVO;
import com.ncncn.domain.request.AttachFileDTO;
import com.ncncn.service.BrandService;
import com.ncncn.service.CategoryService;
import com.ncncn.service.GifticonService;
import com.ncncn.service.ProductService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;


@Controller
@Log4j
@RequestMapping("/user/*")
public class SaleRegisterController {

    final private String barcodepath;
    final private CategoryService cateService;
    final private BrandService brandService;
    final private ProductService prodService;
    final private GifticonService giftiService;

    public SaleRegisterController(
        @Value("#{imgPath['path']}") String barcodepath,
        CategoryService cateService,
        BrandService brandService,
        ProductService prodService,
        GifticonService giftiService
    ) {
        this.barcodepath = barcodepath;
        this.cateService = cateService;
        this.prodService = prodService;
        this.brandService = brandService;
        this.giftiService = giftiService;
    }

    @GetMapping("/deal/saleGifticon")
    public String saleGifticon(HttpServletRequest request , Model model){
        try {
            model.addAttribute("categoryList", cateService.getCategoryList());
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("initError", "???????????? ??????????????? ??????????????????. ?????? ??????????????????");
        }

        try {
            int userId = (int)request.getSession().getAttribute("userId");
            model.addAttribute("userId", userId);
            log.info("userId= " + userId);
        } catch (NullPointerException e) {
            e.printStackTrace();
        }

        log.info("saleGifticon.........");

        return "user/deal/saleGifticon";
    }

    @GetMapping(value = "/getBrandAction", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<List<BrandVO>> getBrandListAjax(String name) {

        // ????????? ??????????????? ???????????? ????????? ?????? ??????
        try {
            String cateName = URLDecoder.decode(name, "UTF-8");
            List<BrandVO> blist = brandService.getBrandList(cateName);

            log.info("get brand list from server...............");
            return new ResponseEntity<>(blist, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }

    @GetMapping(value = "/getProductAction", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<List<ProductVO>> getProductListAjax(String name) {

        // ????????? ???????????? ???????????? ?????? ?????? ??????
        try {
            String brdName = URLDecoder.decode(name, "UTF-8");
            List<ProductVO> plist = prodService.getProductList(brdName);

            log.info("get brand list from server...............");
            return new ResponseEntity<>(plist, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }

    @GetMapping(value = "/getProductObjectAction", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<ProductVO> getProductObjectAjax(String brdName, String prodName) {
        //shift+j ??? ?????????
        // ????????? ?????????, ????????? ???????????? ?????? ??????
        try {
            String brandName = URLDecoder.decode(brdName, "UTF-8");
            String productName = URLDecoder.decode(prodName, "UTF-8");

            log.info("get product object from server...............");
            ProductVO object = prodService.getProductObject(brandName, productName);

            return new ResponseEntity<>(object, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }


    // ????????? ????????? ?????? ??????
    private String getFolder() {

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        Date date = new Date();

        String str = sdf.format(date);

        return str.replace("-", File.separator);
    }

    //???????????? ????????? ????????? ???????????? ??????
    private boolean checkImageType(File file) {

        try {
            String contentType = Files.probeContentType(file.toPath());

            return contentType.startsWith("image");

        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }


    @PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<List<AttachFileDTO>>
    uploadAjaxPost(MultipartFile[] uploadFile) {
        // ????????? ????????? ????????? ??????
        // ???????????? ????????? ????????? ????????? ???????????? ??????
        // ????????? ????????? ?????? ????????? ????????? ??????
        log.info("update ajax post................");

        List<AttachFileDTO> list = new ArrayList<>();
        String uploadFolder = barcodepath + "/barcode";

        String uploadFolderPath = getFolder();
        //make folder --------
        File uploadPath = new File(uploadFolder, getFolder());
        log.info("upload path: " + uploadPath);

        if(uploadPath.exists() == false) {
            try {
                uploadPath.mkdirs();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        // make yyyy/MM/dd folder


        for(MultipartFile multipartFile : uploadFile) {

            AttachFileDTO attachDTO = new AttachFileDTO();

            log.info("---------------------------------------");
            log.info("Upload File Name: " + multipartFile.getOriginalFilename());
            log.info("Upload File Size: " + multipartFile.getSize());

            String uploadFileName = multipartFile.getOriginalFilename();

            // IE has file path
            uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
            log.info("only file name: " + uploadFileName);
            attachDTO.setFileName(uploadFileName);

            //  uuid ??????
            UUID uuid = UUID.randomUUID();

            uploadFileName = uuid.toString() + "_" + uploadFileName;

            try {
                File saveFile = new File(uploadPath, uploadFileName);
                // ????????? ?????? ??????
                multipartFile.transferTo(saveFile);

                attachDTO.setUuid(uuid.toString());
                attachDTO.setUploadPath(uploadFolderPath);

                // check image type file
                // ????????? ????????? ?????? ????????? ????????? ??????
                if (checkImageType(saveFile)) {

                    attachDTO.setImage(true);

                    FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));

                    Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 200, 200);

                    thumbnail.close();
                }

                // add to List
                list.add(attachDTO);

            } catch (Exception e) {
                e.printStackTrace();
            } // end catch
        } // end for
        return new ResponseEntity<>(list, HttpStatus.OK);
    }

    // ????????? ????????? ????????? ??????
    @GetMapping("/display")
    @ResponseBody
    public ResponseEntity<byte[]> getFile(String fileName) {

        log.info("fileName: " + fileName);

        File file = new File(barcodepath + fileName);

        log.info("barcode Path : " + barcodepath + fileName);
        log.info("file: " + file);

        ResponseEntity<byte[]> result = null;

        try {
            HttpHeaders header= new HttpHeaders();

            // MIME Type ??????
            header.add("Content-Type", Files.probeContentType(file.toPath()));
            // ?????? ??????
            result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return result;
    }


    @PostMapping(value = "/registerGifticonAction", consumes="application/json", produces={MediaType.TEXT_PLAIN_VALUE})
    @ResponseBody
    public ResponseEntity<Void> registerGifticonAction(@RequestBody GifticonVO gifticon) {

        try {
            giftiService.registerGifticon(gifticon);
            log.info("registered Gifticon successfully.............");
            return new ResponseEntity<>(HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

}
