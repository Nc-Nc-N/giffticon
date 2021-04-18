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

import javax.servlet.http.HttpServletRequest;

@Controller
@Log4j
@AllArgsConstructor
public class FaqController {

	private FaqService service;

	// 사용자

	@GetMapping("/user/mypage/faqBoard")
	public String faqBoard(HttpServletRequest request, CriteriaCs cri, Model model){

		log.info("list: " + cri);
		int userId = (int) request.getSession().getAttribute("userId");

		model.addAttribute("list", service.getList(cri));
//		model.addAttribute("pageMaker", new PageDTOCs(cri, 120));

		int total = service.getTotal(cri);

		log.info("total: " + total);

		model.addAttribute("pageMaker", new PageDTOCs(cri, total));

		return "user/cs/faqBoard";
	}




	// 관리자


	@GetMapping("admin/adminFaq")
	public  String adminFaq(HttpServletRequest request,CriteriaCs cri, Model model){

		log.info("list: " + cri);

		int userId = (int) request.getSession().getAttribute("userId");

		model.addAttribute("list", service.getList(cri));
//		model.addAttribute("pageMaker", new PageDTOCs(cri, 120));

		int total = service.getTotal(cri);

		log.info("total: " + total);

		model.addAttribute("pageMaker", new PageDTOCs(cri, total));

		return "admin/cs/adminFaq";

	}


	@PostMapping("/admin/adminFaq/register")
	public String register(HttpServletRequest request, CsFaqVO faq, RedirectAttributes rttr){

		log.info("register: " + faq);
		int userId = (int) request.getSession().getAttribute("userId");

		service.register(faq);

		rttr.addFlashAttribute("result", faq.getId());

		return "redirect:/admin/adminFaq";
	}

	@PostMapping("/admin/adminFaq/modify")
	public String modify(HttpServletRequest request, CsFaqVO faq, @ModelAttribute("cri") CriteriaCs cri, RedirectAttributes rttr){

		log.info("modify: " + faq);

		int userId = (int) request.getSession().getAttribute("userId");

		service.modify(faq);
		if(service.modify(faq)){
			rttr.addFlashAttribute("result", "success");
		}

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());

		return "redirect:/admin/adminFaq";
	}

	@PostMapping("/admin/adminFaq/remove")
	public String remove(HttpServletRequest request, @RequestParam("id") int id, @ModelAttribute("cri") CriteriaCs cri, RedirectAttributes rttr){


		log.info("remove...." + id);

		int userId = (int) request.getSession().getAttribute("userId");

		if (service.remove(id)){
			rttr.addFlashAttribute("result","success");
		}

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());

		return "redirect:/admin/adminFaq";
	}



	//Modal에 데이터 받기위해 apax를 사용하여 객체 전달.
	@GetMapping(value = "/admin/faq", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<CsFaqVO> getNotice(@RequestParam("id") int id) {

		CsFaqVO faqVO = service.get(id);

		return new ResponseEntity<>(faqVO,HttpStatus.OK);
	}

}
