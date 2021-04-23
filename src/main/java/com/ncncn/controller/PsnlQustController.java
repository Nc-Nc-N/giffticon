package com.ncncn.controller;

import javax.servlet.http.HttpServletRequest;

import com.ncncn.domain.CsPsnlQustVO;
import com.ncncn.domain.pagination.CsCriteria;
import com.ncncn.domain.pagination.PageDTO;
import com.ncncn.service.PsnlQustService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@Log4j
@AllArgsConstructor
public class PsnlQustController {

	private PsnlQustService service;

	// 사용자

	@GetMapping("/user/mypage/psnlQustBoard")
	public String faqBoard(HttpServletRequest request, CsCriteria cri, Model model) {

		log.info(cri.getType());
		log.info(cri.getTypeArr());

		int userId = (int) request.getSession().getAttribute("userId");

		model.addAttribute("list", service.getListPsnlQust(cri, userId));

		log.info("userId : " + userId);

		int total = service.getTotalPsnlQust(cri, userId);

		log.info("total: " + total);

		model.addAttribute("pageMaker", new PageDTO(cri, total));


		return "user/cs/psnlQustBoard";
	}


	@GetMapping("/user/mypage/psnlQustBoard/register")
	public String registerPsnlQust(HttpServletRequest request) {

		int userId = (int) request.getSession().getAttribute("userId");

		return "user/cs/registerPsnlQust";
	}

	@PostMapping("/user/mypage/psnlQustBoard/register")
	public String register(HttpServletRequest request, CsPsnlQustVO qna, RedirectAttributes rttr) {

		log.info("register: " + qna);

		int userId = (int) request.getSession().getAttribute("userId");

		service.register(qna);

		rttr.addFlashAttribute("result", qna.getId());

		return "redirect:/user/mypage/psnlQustBoard";
	}


	@PostMapping("/user/mypage/psnlQustBoard/modify")
	public String modifyUser(HttpServletRequest request, CsPsnlQustVO qna, @ModelAttribute("cri") CsCriteria cri, RedirectAttributes rttr) {

		log.info("modify: " + qna);

		int userId = (int) request.getSession().getAttribute("userId");

		service.modifyUser(qna);
		if (service.modifyUser(qna)) {
			rttr.addFlashAttribute("result", "success");
		}

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());

		return "redirect:/user/mypage/psnlQustBoard";
	}


	@PostMapping("/user/mypage/psnlQustBoard/remove")
	public String removeUser(HttpServletRequest request, @RequestParam("id") int id, @ModelAttribute("cri") CsCriteria cri, RedirectAttributes rttr) {


		log.info("remove...." + id);

		int userId = (int) request.getSession().getAttribute("userId");

		if (service.remove(id)) {
			rttr.addFlashAttribute("result", "success");
		}

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());

		return "redirect:/user/mypage/psnlQustBoard";
	}


	// 관리자

	@GetMapping("/admin/adminPsnlQust")
	public String adminFaq(HttpServletRequest request, CsCriteria cri, Model model) {

		log.info("list: " + cri);
		int userId = (int) request.getSession().getAttribute("userId");
		model.addAttribute("userId", userId);
		model.addAttribute("list", service.getList(cri));
//		model.addAttribute("pageMaker", new PageDTOCs(cri, 120));

		int total = service.getTotal(cri);

		log.info("total: " + total);

		model.addAttribute("pageMaker", new PageDTO(cri, total));

		return "admin/cs/adminPsnlQust";

	}

	@PostMapping("/admin/adminPsnlQust/modify")
	public String modify(HttpServletRequest request, CsPsnlQustVO qna, @ModelAttribute("cri") CsCriteria cri, RedirectAttributes rttr) {

		log.info("modify: " + qna);

		int userId = (int) request.getSession().getAttribute("userId");

		service.modify(qna);
		if (service.modify(qna)) {
			rttr.addFlashAttribute("result", "success");
		}

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());

		return "redirect:/admin/adminPsnlQust";
	}


	@PostMapping("/admin/adminPsnlQust/remove")
	public String remove(HttpServletRequest request, @RequestParam("id") int id, @ModelAttribute("cri") CsCriteria cri, RedirectAttributes rttr) {


		log.info("remove...." + id);

		int userId = (int) request.getSession().getAttribute("userId");

		if (service.remove(id)) {
			rttr.addFlashAttribute("result", "success");
		}

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());

		return "redirect:/admin/adminPsnlQust";
	}


	//Modal에 데이터 받기위해 apax를 사용하여 객체 전달.
	@GetMapping(value = "/psnl", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<CsPsnlQustVO> getNotice(@RequestParam("id") int id) {

		CsPsnlQustVO qnaVO = service.get(id);

		return new ResponseEntity<>(qnaVO, HttpStatus.OK);
	}

}
