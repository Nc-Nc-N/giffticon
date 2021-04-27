package com.ncncn.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ncncn.domain.SaleRqustVO;
import com.ncncn.domain.pagination.PageDTO;
import com.ncncn.domain.pagination.SaleRqustCriteria;
import com.ncncn.domain.request.RqustRejectDTO;
import com.ncncn.service.SaleRqustService;
import lombok.extern.log4j.Log4j;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/request")
@Log4j
public class SaleRequestController {

	private SaleRqustService saleRqustService;

	private JavaMailSender javaMailSender;

	public SaleRequestController(SaleRqustService saleRqustService, JavaMailSender javaMailSender) {
		this.saleRqustService = saleRqustService;
		this.javaMailSender = javaMailSender;
	}

	@GetMapping("/list")
	public void getRequestList(SaleRqustCriteria cri, Model model) {
		try {
			List<SaleRqustVO> rqustList = saleRqustService.getAllRqust(cri);
			int total = saleRqustService.getTotalCount(cri);
			model.addAttribute("rqustList", rqustList);
			model.addAttribute("pageMaker", new PageDTO(cri, total));
		} catch (Exception e) {
			model.addAttribute("error", "해당 정보를 조회하는데 문제가 발생했습니다.");
		}
	}

	@GetMapping(value = "/{id}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Map<String, Object>> getRequest(@PathVariable("id") int id) {
		Map<String, Object> rqust = new HashMap<>();

		try {
			rqust = saleRqustService.getRqustById(id);
		} catch (Exception e) {
			rqust.put("error", e.getMessage());
			return new ResponseEntity<>(rqust, HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<>(rqust, HttpStatus.OK);
	}

	@PatchMapping(value = "/{id}")
	public ResponseEntity<String> approveRequest(@PathVariable("id") int id) {
		try {
			int result = saleRqustService.modifyStusCodeAndAprvDt(id);
		} catch (Exception e) {
			return new ResponseEntity<>("error", HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return new ResponseEntity<>("success", HttpStatus.OK);
	}

	@DeleteMapping(value = "/{id}", consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> deleteRequset(@PathVariable("id") int id, @RequestBody RqustRejectDTO rqustRejectDTO) {
		try {
			Map<String, Object> rqust = saleRqustService.getRqustById(id);
//			int result = saleRqustService.removeRqust(id);
//
//			// 반려사유 메일 전송
//			SimpleMailMessage message = new SimpleMailMessage();
//			message.setTo(rqustRejectDTO.getEmail());
//			message.setSubject("[기쁘티콘] 판매요청에 대한 안내메일입니다.");
//			message.setText(getMessage(rqust, rqustRejectDTO.getCause()));
//
//			javaMailSender.send(message);

			log.info(getMessage(rqust, rqustRejectDTO.getCause()));
		} catch (Exception e) {
			return new ResponseEntity<>("error", HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return new ResponseEntity<>("success", HttpStatus.OK);
	}

	private String getMessage(Map<String, Object> rqust, String cause) {
		StringBuilder message = new StringBuilder();

		message.append(rqust.get("requester")).append(" 님, 안녕하세요. 기쁘티콘입니다.\n");
		message.append("요청하신 \"[").append(rqust.get("brdName")).append("] ");
		message.append(rqust.get("prodName")).append("\" 상품의 판매요청이 반려되어 안내메일드립니다.\n\n");
		message.append("상품분류: ").append(rqust.get("cateName")).append(" > ").append(rqust.get("brdName")).append("\n");
		message.append("상품명: ").append(rqust.get("prodName")).append("\n");
		message.append("판매가: ").append(rqust.get("dcPrc")).append(" 원\n");
		message.append("유효기간: ~ ").append(rqust.get("expirDt")).append("\n");
		message.append("바코드번호: ").append(rqust.get("brcd")).append("\n");
		message.append("요청일: ").append(rqust.get("inDate")).append("\n\n");
		message.append("반려사유: ").append(cause).append("\n\n");
		message.append("문의사항은 1:1문의를 통해 남겨주세요. 기쁘티콘을 이용해주셔서 감사합니다.");

		return message.toString();
	}
}
