package com.ncncn.controller;

import com.ncncn.domain.CriteriaCs;
import com.ncncn.domain.CsNoticeVO;
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

import java.util.HashMap;
import java.util.Map;

@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/cs/*")
public class NoticeController {

	private NoticeService service;

	// 사용자

	@GetMapping("/noticeBoard")
	public String csNotice(){
		return "user/cs/noticeBoard";
	}


	// 관리자

//	@GetMapping("/adminNotice")
//	public  String adminNotice(Model model){
//
//
//		model.addAttribute("list", service.getList());	// 공지사항 리스트
//		return "admin/cs/adminNotice";
//
//	}

	@GetMapping("/adminNotice")
	public  String adminNotice(CriteriaCs cri, Model model){

		log.info("list: " + cri);
		model.addAttribute("list", service.getList(cri));
		model.addAttribute("pageMaker", new PageDTOCs(cri, 120));
		return "admin/cs/adminNotice";

	}


	@PostMapping("/adminNotice/register")
	public String register(CsNoticeVO notice, RedirectAttributes rttr){

		log.info("register: " + notice);

		service.register(notice);

		rttr.addFlashAttribute("result", notice.getId());

		return "redirect:/cs/adminNotice";
	}

	@PostMapping("/adminNotice/modify")
	public String modify(CsNoticeVO notice, @ModelAttribute("cri") CriteriaCs cri, RedirectAttributes rttr){

		log.info("modify: " + notice);

		if(service.modify(notice)){
			rttr.addFlashAttribute("result", "success");
		}

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());

		return "redirect:/cs/adminNotice";
	}

	@PostMapping("/adminNotice/remove")
	public String remove(@RequestParam("id") int id, RedirectAttributes rttr){

		log.info("remove...." + id);
		if (service.remove(id)){
			rttr.addFlashAttribute("result","success");
		}

		return "redirect:/cs/adminNotice";
	}



	//Modal에 데이터 받기위해 apax를 사용하여 객체 전달.
	@GetMapping(value = "/notice", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<CsNoticeVO> getNotice(@RequestParam("id") int id) {

		CsNoticeVO noticeVO = service.get(id);

		return new ResponseEntity<>(noticeVO,HttpStatus.OK);
	}

}
