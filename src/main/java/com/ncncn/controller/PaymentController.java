package com.ncncn.controller;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/user/*")
@AllArgsConstructor
public class PaymentController {

	@GetMapping("/mypage/payment")
	public String main(HttpServletRequest request, Model model) {

		return "/user/mypage/mypage_selling_billing_page";
	}
}
