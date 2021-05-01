package com.ncncn.controller;

import com.ncncn.domain.AdminProdListVO;
import com.ncncn.domain.BrandVO;
import com.ncncn.domain.CategoryVO;
import com.ncncn.domain.pagination.PageDTO;
import com.ncncn.domain.pagination.ProdCriteria;
import com.ncncn.domain.request.AttachFileDTO;
import com.ncncn.domain.request.ProdRegisterDTO;
import com.ncncn.service.BrandService;
import com.ncncn.service.CategoryService;
import com.ncncn.service.ProductService;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/admin")
@Log4j
public class ProdManagingController {

    private ProductService productService;

    private CategoryService categoryService;

    private BrandService brandService;

    private FileOutputStream fileOutputStream;

    public ProdManagingController(ProductService productService, CategoryService categoryService, BrandService brandService) {
        this.productService = productService;
        this.categoryService = categoryService;
        this.brandService = brandService;
    }

    @GetMapping("/product/prodList")
    public void getProdList(ProdCriteria cri, Model model) {
        try {
            List<AdminProdListVO> prodList = productService.getAllProduct(cri);
            int total = productService.countAllProd(cri);
            model.addAttribute("prodList", prodList);
            model.addAttribute("pageMaker", new PageDTO(cri, total));
        } catch (Exception e) {
            model.addAttribute("error", "해당 정보를 조회하는데 문제가 발생했습니다.");
        }
    }

    @GetMapping(value = "/product/cateList", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<CategoryVO>> getCateList() {
        List<CategoryVO> cateList;
        try {
            cateList = categoryService.getCategoryList();
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
        log.info(cateList);
        return new ResponseEntity<>(cateList, HttpStatus.OK);
    }

    @GetMapping(value = "/product/category/{cateCode}/brdList", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<BrandVO>> getBrdList(@PathVariable("cateCode") String cateCode) {
        List<BrandVO> brdList;
        try {
            brdList = brandService.getBrdList(cateCode);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
        log.info(brdList);
        return new ResponseEntity<>(brdList, HttpStatus.OK);
    }

    @PostMapping(value = "/product/register", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<String> registerProduct(ProdRegisterDTO product, MultipartHttpServletRequest request) {
        log.info(product);

        String uploadFolder = "C:/Users/USER/Desktop/Projects/giffticon/src/main/webapp/resources/img/";
        String prodImgFolder = "product/" + product.getCateCode() + "/" + product.getBrdCode() + "/";

        log.info("---");

        MultipartFile multipartFile = product.getProdImg();

        log.info(request.getFile("prodImg"));

        try {
            log.info(multipartFile.getOriginalFilename());
            byte[] fileData = multipartFile.getBytes();
            fileOutputStream = new FileOutputStream(uploadFolder + prodImgFolder + multipartFile.getOriginalFilename());
            fileOutputStream.write(fileData);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        } finally {
            if (fileOutputStream != null) {
                try {
                    fileOutputStream.close();
                } catch (Exception e){
                    e.printStackTrace();
                }
            }
        }

        return new ResponseEntity<>("success", HttpStatus.OK);
    }

}
