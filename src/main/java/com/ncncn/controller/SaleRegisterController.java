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
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;


@Controller
@Log4j
@RequestMapping("/user/*")
@AllArgsConstructor
public class SaleRegisterController {

    private CategoryService cateService;
    private BrandService brandService;
    private ProductService prodService;
    private GifticonService giftiService;

    @GetMapping("/deal/saleGifticon")
    public String saleGifticon(HttpServletRequest request , Model model){

        model.addAttribute("categoryList", cateService.getCategoryList());

        int userId = 0;

        try {
            userId = (int) request.getSession().getAttribute("userId");
        } catch (NullPointerException e) {
            e.printStackTrace();
        }

        model.addAttribute("userId", userId);

        log.info("userId= " + userId);

        log.info("saleGifticon.........");

        return "user/deal/saleGifticon";
    }

    @PostMapping(value = "/getBrandAction", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<List<BrandVO>> getBrandListAjax(@RequestParam("name") String name) {

        log.info("get brand list from server...............");
        List<BrandVO> blist = brandService.getBrandList(name);

        return new ResponseEntity<>(blist, HttpStatus.OK);
    }

    @PostMapping(value = "/getProductAction", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<List<ProductVO>> getProductListAjax(@RequestParam("name") String name) {

        log.info("get brand list from server...............");
        List<ProductVO> plist = prodService.getProductList(name);

        return new ResponseEntity<>(plist, HttpStatus.OK);
    }

    @PostMapping(value = "/getProductObjectAction", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<ProductVO> getProductObjectAjax(
            @RequestParam("brdName") String brdName, @RequestParam("prodName") String prodName) {

        log.info("get brand list from server...............");
        ProductVO object = prodService.getProductObject(brdName, prodName);

        return new ResponseEntity<>(object, HttpStatus.OK);
    }


    // 업로드 이미지 폴더 생성
    private String getFolder() {

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        Date date = new Date();

        String str = sdf.format(date);

        return str.replace("-", File.separator);
    }

    //업로드된 파일이 이미지 타입인지 검사
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

        log.info("update ajax post................");

        List<AttachFileDTO> list = new ArrayList<>();
        String uploadFolder = "/Users/asdddq/Desktop/MyFolder/팀프로젝트/Git0418/giffticon/src/main/webapp/resources/img/barcode";

        String uploadFolderPath = getFolder();
        //make folder --------
        File uploadPath = new File(uploadFolder, getFolder());
        log.info("upload path: " + uploadPath);

        if(uploadPath.exists() == false) {
            uploadPath.mkdirs();
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

            UUID uuid = UUID.randomUUID();

            uploadFileName = uuid.toString() + "_" + uploadFileName;

            try {
                File saveFile = new File(uploadPath, uploadFileName);
                multipartFile.transferTo(saveFile);

                attachDTO.setUuid(uuid.toString());
                attachDTO.setUploadPath(uploadFolderPath);

                // check image type file
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

    // 526page 썸네일 이미지 데이터 전송
    @GetMapping("/display")
    @ResponseBody
    public ResponseEntity<byte[]> getFile(String fileName) {

        log.info("fileName: " + fileName);

        File file = new File("/Users/asdddq/Desktop/MyFolder/팀프로젝트/Git0418/giffticon/src/main/webapp/resources/img/barcode" + fileName);

        log.info("file: " + file);

        ResponseEntity<byte[]> result = null;

        try {
            HttpHeaders header= new HttpHeaders();

            header.add("Content-Type", Files.probeContentType(file.toPath()));
            result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return result;
    }


    @PostMapping(value = "/registerGifticonAction", consumes="application/json", produces={MediaType.TEXT_PLAIN_VALUE})
    @ResponseBody
    public void registerGifticonAction(@RequestBody GifticonVO gifticon) {
        log.info("register Gifticon controller.............");

        giftiService.registerGifticon(gifticon);

    }



}
