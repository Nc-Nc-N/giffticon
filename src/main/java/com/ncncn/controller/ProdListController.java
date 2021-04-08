package com.ncncn.controller;

import com.ncncn.service.ProdService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@Log4j
@RequestMapping("/user/*")
@AllArgsConstructor
public class ProdListController {

	private ProdService service;

	@GetMapping(value = "/prod_list")
	public void prodList(@RequestParam("code") String code, @RequestParam("orderby") String orderby, Model model){

		model.addAttribute("category", service.getCate(code));
		model.addAttribute("brandList", service.getBrandList(code));
		model.addAttribute("gifti", service.getGifti(code, orderby));
	}
}
