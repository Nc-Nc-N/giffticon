package com.ncncn.controller;

import com.ncncn.domain.CriteriaCs;
import com.ncncn.domain.CsNoticeVO;
import com.ncncn.domain.PageDTO;
import com.ncncn.domain.PageDTOCs;
import com.ncncn.service.NoticeService;
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
public class NoticeController {

	private NoticeService service;

	// 사용자

	@GetMapping("user/cs/noticeBoard")
	public String csNotice(CriteriaCs cri, Model model){

		log.info("list: " + cri);
		model.addAttribute("list", service.getList(cri));
//		model.addAttribute("pageMaker", new PageDTOCs(cri, 120));

		int total = service.getTotal(cri);

		log.info("total: " + total);

		model.addAttribute("pageMaker", new PageDTO(cri, total));

		return "user/cs/noticeBoard";
	}



	// 관리자

	@GetMapping("admin/adminNotice")
	public  String adminNotice(HttpServletRequest request,CriteriaCs cri, Model model){

		log.info("list: " + cri);
		model.addAttribute("list", service.getList(cri));
//		model.addAttribute("pageMaker", new PageDTOCs(cri, 120));

		int total = service.getTotal(cri);

		log.info("total: " + total);

		model.addAttribute("pageMaker", new PageDTO(cri, total));

		int userId = 0;
		//userId 0일경우 예외처리 해줄 것
		try {
			userId = (int) request.getSession().getAttribute("userId");
			model.addAttribute("userId", userId);
		} catch (NullPointerException e) {
			e.printStackTrace();
		}

		return "admin/cs/adminNotice";

	}


	@PostMapping("/admin/adminNotice/register")
	public String register(HttpServletRequest request, CsNoticeVO notice, RedirectAttributes rttr){

		log.info("register: " + notice);

		int userId = (int) request.getSession().getAttribute("userId");
		service.register(notice);
		rttr.addFlashAttribute("result", notice.getId());

		return "redirect:/admin/adminNotice";
	}

	@PostMapping("/admin/adminNotice/modify")
	public String modify(HttpServletRequest request, CsNoticeVO notice, @ModelAttribute("cri") CriteriaCs cri, RedirectAttributes rttr){

		log.info("modify: " + notice);

		int userId = (int) request.getSession().getAttribute("userId");

		service.modify(notice);
		if(service.modify(notice)){
			rttr.addFlashAttribute("result", "success");
		}

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());

		return "redirect:/admin/adminNotice";
	}

	@PostMapping("/admin/adminNotice/remove")
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

		return "redirect:/admin/adminNotice";
	}



	//Modal에 데이터 받기위해 ajax를 사용하여 객체 전달.
	@GetMapping(value = "/admin/notice", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<CsNoticeVO> getNotice(@RequestParam("id") int id) {

		CsNoticeVO noticeVO = service.get(id);

		return new ResponseEntity<>(noticeVO,HttpStatus.OK);
	}

}
