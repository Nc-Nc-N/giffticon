package com.ncncn.controller;

import com.ncncn.domain.pagination.CsCriteria;
import com.ncncn.domain.CsFaqVO;
import com.ncncn.domain.pagination.PageDTO;
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

	@GetMapping("/user/cs/faqBoard")

	public String faqBoard(CsCriteria cri, Model model){

		log.info("list: " + cri);

		try {

			model.addAttribute("list", service.getListUser(cri));

			int total = service.getTotalUser(cri);

			log.info("total: " + total);

			model.addAttribute("pageMaker", new PageDTO(cri, total));

		}catch (Exception e){

			e.printStackTrace();
			model.addAttribute("error", e.getMessage());
		}

		return "user/cs/faqBoard";
	}




	// 관리자


	@GetMapping("/admin/adminFaq")
	public  String adminFaq(HttpServletRequest request, CsCriteria cri, Model model){

		log.info("list: " + cri);

		try {

			int userId = (int) request.getSession().getAttribute("userId");
			model.addAttribute("userId", userId);
			model.addAttribute("list", service.getList(cri));

			int total = service.getTotal(cri);

			log.info("total: " + total);

			model.addAttribute("pageMaker", new PageDTO(cri, total));

		}catch (Exception e){
			e.printStackTrace();
			model.addAttribute("error", e.getMessage());
		}

		return "admin/cs/adminFaq";

	}

	//게시물 등록
	@PostMapping("/admin/adminFaq/register")
	public String register(HttpServletRequest request, CsFaqVO faq, RedirectAttributes rttr){

		log.info("register: " + faq);

		try {

			int userId = (int) request.getSession().getAttribute("userId");

			service.register(faq);

			rttr.addFlashAttribute("result", faq.getId());

		}catch (Exception e){
			e.printStackTrace();
			rttr.addAttribute("error",HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return "redirect:/admin/adminFaq";
	}

	//게시물 수정
	@PostMapping("/admin/adminFaq/modify")
	public String modify(HttpServletRequest request, CsFaqVO faq, @ModelAttribute("cri") CsCriteria cri, RedirectAttributes rttr){

		log.info("modify: " + faq);

		try {

			int userId = (int) request.getSession().getAttribute("userId");

			service.modify(faq);

			rttr.addAttribute("pageNum", cri.getPageNum());
			rttr.addAttribute("amount", cri.getAmount());
			rttr.addAttribute("type", cri.getType());
			rttr.addAttribute("keyword", cri.getKeyword());

		}catch (Exception e){
			e.printStackTrace();
			rttr.addAttribute("error", HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return "redirect:/admin/adminFaq";
	}

	//게시물 삭제
	@PostMapping("/admin/adminFaq/remove")
	public String remove(HttpServletRequest request, @RequestParam("id") int id, @ModelAttribute("cri") CsCriteria cri, RedirectAttributes rttr){


		log.info("remove...." + id);

		try {

			int userId = (int) request.getSession().getAttribute("userId");

			service.remove(id);

			rttr.addAttribute("pageNum", cri.getPageNum());
			rttr.addAttribute("amount", cri.getAmount());
			rttr.addAttribute("type", cri.getType());
			rttr.addAttribute("keyword", cri.getKeyword());

		}catch (Exception e){
			e.printStackTrace();
			rttr.addAttribute("error",HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return "redirect:/admin/adminFaq";
	}



	//Modal에 데이터 받기위해 apax를 사용하여 객체 전달.
	@GetMapping(value = "/admin/faq", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<CsFaqVO> getNotice(@RequestParam("id") int id) {

		try {

			CsFaqVO faqVO = service.get(id);

			return new ResponseEntity<>(faqVO,HttpStatus.OK);

		}catch (Exception e){
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

}
