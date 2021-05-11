package com.ncncn.controller;

import com.ncncn.domain.pagination.CsCriteria;
import com.ncncn.domain.CsNoticeVO;
import com.ncncn.domain.pagination.PageDTO;
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

	@GetMapping("/user/cs/noticeBoard")
	public String csNotice(CsCriteria cri, Model model){


		try{
			log.info("list: " + cri);
			model.addAttribute("list", service.getList(cri));

			int total = service.getTotal(cri);

			log.info("total: " + total);

			model.addAttribute("pageMaker", new PageDTO(cri, total));

		}catch (Exception e){
			e.printStackTrace();
			model.addAttribute("error", e.getMessage());
		}

		return "user/cs/noticeBoard";
	}



	// 관리자

	@GetMapping("/admin/adminNotice")
	public  String adminNotice(HttpServletRequest request, CsCriteria cri, Model model){


		try {

			log.info("list: " + cri);
			model.addAttribute("list", service.getList(cri));

			int total = service.getTotal(cri);

			log.info("total: " + total);

			model.addAttribute("pageMaker", new PageDTO(cri, total));

			int userId = 0;

			userId = (int) request.getSession().getAttribute("userId");

			model.addAttribute("userId", userId);

		} catch (NullPointerException e) {
			e.printStackTrace();
			model.addAttribute("error", e.getMessage());
		}

		return "admin/cs/adminNotice";

	}

	//게시물 등록
	@PostMapping("/admin/adminNotice/register")
	public String register(HttpServletRequest request, CsNoticeVO notice, RedirectAttributes rttr){

		try{

			log.info("register: " + notice);

			int userId = (int) request.getSession().getAttribute("userId");

			service.register(notice);

			rttr.addFlashAttribute("result", notice.getId());

		}catch (Exception e){
			e.printStackTrace();
			rttr.addAttribute("error", HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return "redirect:/admin/adminNotice";
	}

	//게시물 수정
	@PostMapping("/admin/adminNotice/modify")
	public String modify(HttpServletRequest request, CsNoticeVO notice, @ModelAttribute("cri") CsCriteria cri, RedirectAttributes rttr){


		try {

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

		}catch (Exception e){
			e.printStackTrace();
			rttr.addAttribute("error", HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return "redirect:/admin/adminNotice";
	}

	//게시물 삭제
	@PostMapping("/admin/adminNotice/remove")
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

		return "redirect:/admin/adminNotice";
	}



	//Modal에 데이터 받기위해 ajax를 사용하여 객체 전달.
	@GetMapping(value = "/admin/notice", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<CsNoticeVO> getNotice(@RequestParam("id") int id) {

		try {

			CsNoticeVO noticeVO = service.get(id);

			return new ResponseEntity<>(noticeVO,HttpStatus.OK);

		}catch (Exception e){

			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}

	}

}
