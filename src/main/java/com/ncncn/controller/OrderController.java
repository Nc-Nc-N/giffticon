package com.ncncn.controller;

import com.ncncn.domain.UserInfoDTO;
import com.ncncn.service.GifticonService;
import com.ncncn.service.UserService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@Controller
@AllArgsConstructor
@Log4j
public class OrderController {

	private GifticonService giftiService;
	private UserService userService;

	@GetMapping("/user/gifti_order")
	public String giftiOrder(@RequestParam("gifti") int id, HttpServletRequest request,  Model model) {


		try{
			int userId = (int) request.getSession().getAttribute("userId");
			UserInfoDTO user = userService.getMyInfo(userId);

			model.addAttribute("gifticon", giftiService.getGifticon(id));
			model.addAttribute("user", user);

		}catch (Exception e){
			model.addAttribute("error", "상품 조회 중 문제가 발생했습니다.");
		}
		return "user/gifticon/gifti_order";
	}

	@PostMapping("/payment_cmplt")
	public String paymentCmplt(){

		return "user/gifticon/payment_cmplt";
	}
}
