package com.ncncn.controller;


import com.ncncn.domain.CategoryVO;
import com.ncncn.mapper.DealMapper;
import com.ncncn.service.DealService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Log4j
@RequestMapping("/user/*")
@AllArgsConstructor
public class dealController {

    private DealService service;

    @GetMapping("/deal/saleGifticon")
    public void saleGifticon(Model model){
        model.addAttribute("categoryList", service.getCategoryList());
        model.addAttribute("brandList", service.getBrandList());
        model.addAttribute("productList", service.getProductList());

        log.info("saleGifticon.........");

    }

}
