package com.ncncn.controller;

import com.ncncn.domain.CriteriaCs;
import com.ncncn.domain.CsFaqVO;
import com.ncncn.domain.PageDTOCs;
import com.ncncn.service.FaqService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/cs/*")
public class FaqController {

	private FaqService service;

	// 사용자

	@GetMapping("/faqBoard")
	public String faqBoard(CriteriaCs cri, Model model){

		log.info("list: " + cri);
		model.addAttribute("list", service.getList(cri));
//		model.addAttribute("pageMaker", new PageDTOCs(cri, 120));

		int total = service.getTotal(cri);

		log.info("total: " + total);

		model.addAttribute("pageMaker", new PageDTOCs(cri, total));

		return "user/cs/faqBoard";
	}




	// 관리자


	@GetMapping("/adminFaq")
	public  String adminFaq(CriteriaCs cri, Model model){

		log.info("list: " + cri);
		model.addAttribute("list", service.getList(cri));
//		model.addAttribute("pageMaker", new PageDTOCs(cri, 120));

		int total = service.getTotal(cri);

		log.info("total: " + total);

		model.addAttribute("pageMaker", new PageDTOCs(cri, total));

		return "admin/cs/adminFaq";

	}


	@PostMapping("/adminFaq/register")
	public String register(CsFaqVO faq, RedirectAttributes rttr){

		log.info("register: " + faq);

		service.register(faq);

		rttr.addFlashAttribute("result", faq.getId());

		return "redirect:/cs/adminFaq";
	}

	@PostMapping("/adminFaq/modify")
	public String modify(CsFaqVO faq, @ModelAttribute("cri") CriteriaCs cri, RedirectAttributes rttr){

		log.info("modify: " + faq);
		service.modify(faq);
		if(service.modify(faq)){
			rttr.addFlashAttribute("result", "success");
		}

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());

		return "redirect:/cs/adminFaq";
	}

	@PostMapping("/adminFaq/remove")
	public String remove(@RequestParam("id") int id, @ModelAttribute("cri") CriteriaCs cri, RedirectAttributes rttr){


		log.info("remove...." + id);
		if (service.remove(id)){
			rttr.addFlashAttribute("result","success");
		}

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());

		return "redirect:/cs/adminFaq";
	}



	//Modal에 데이터 받기위해 apax를 사용하여 객체 전달.
	@GetMapping(value = "/faq", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<CsFaqVO> getNotice(@RequestParam("id") int id) {

		CsFaqVO faqVO = service.get(id);

		return new ResponseEntity<>(faqVO,HttpStatus.OK);
	}

}
