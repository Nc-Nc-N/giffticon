package com.ncncn.controller;

import com.ncncn.domain.AdminProdListVO;
import com.ncncn.domain.pagination.PageDTO;
import com.ncncn.domain.pagination.ProdCriteria;
import com.ncncn.service.ProductService;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/admin")
@Log4j
public class ProdManagingController {

    private ProductService productService;

    public ProdManagingController(ProductService productService) {
        this.productService = productService;
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
}
