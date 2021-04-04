package com.ncncn.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
//@RequestMapping("/cs/*")
public class NoticeController {

	@GetMapping("/noticeBoard")
	public String csNotice(){
		return "user/cs/noticeBoard";
	}




	@GetMapping("/adminNotice")
	public  String adminNotice(){
		return "admin/cs/adminNotice";
	}

}
