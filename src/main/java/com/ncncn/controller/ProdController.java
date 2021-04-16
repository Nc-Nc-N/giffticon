package com.ncncn.controller;

import com.ncncn.domain.PageDTOHY;
import com.ncncn.domain.GiftiCriteria;
import com.ncncn.service.ProdService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@Log4j
@RequestMapping("/user/*")
@AllArgsConstructor
public class ProdController {

	private ProdService service;

	// 기프티콘 목록 페이지
	@GetMapping(value = "/prod_list")
	public void prodList(GiftiCriteria cri, Model model){

		String code = cri.getCode();
		int total = service.getTotal(cri);

		model.addAttribute("category", service.getCate(code));
		model.addAttribute("brandList", service.getBrandList(code));
		model.addAttribute("gifti", service.getGiftiWithPaging(cri));
		model.addAttribute("pageMaker", new PageDTOHY(cri, total));
	}

	// 기프티콘 상세 페이지
	@GetMapping(value = "/prod_detail")
	public void prodDetail(GiftiCriteria cri, Model model){

		String code = cri.getCode();
		int total = service.getTotal(cri);

		model.addAttribute("category", service.getCate(code));
		model.addAttribute("brandList", service.getBrandList(code));
		model.addAttribute("giftiList", service.getGiftiList(code));
		model.addAttribute("pageMaker", new PageDTOHY(cri, total)); // 카테고리바에서 prod_list로 이동
		model.addAttribute("gifticon", service.getGifti(code));

	}
}

