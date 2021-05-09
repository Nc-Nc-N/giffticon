package com.ncncn.controller;

import com.ncncn.domain.PntHistVO;
import com.ncncn.domain.UserInfoDTO;
import com.ncncn.service.ConService;
import com.ncncn.service.UserService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/user/mypage")
@Log4j
@AllArgsConstructor
public class ConController {

	UserService userService;
	ConService pointService;

	// 콘 충전하기 페이지
	@GetMapping(value = "/addCon")
	public void addConPage(HttpServletRequest request, Model model){

		int userId = (int) request.getSession().getAttribute("userId");
		UserInfoDTO user = userService.getMyInfo(userId);
		String email = user.getEmail();
		String name = user.getName();
		String tel = user.getTelNo();
		int userCon = userService.readbyId(userId).getPnt();

		model.addAttribute("email", email);
		model.addAttribute("name", name);
		model.addAttribute("tel", tel);
		model.addAttribute("userCon", userCon);

	}

	// 콘 충전 저장, 사용자 보유 콘 update
	@GetMapping("/addCon/con")
	public @ResponseBody void addCon(int amount, PntHistVO pntHistVO, HttpServletRequest request){

		log.info(amount);

		// 콘 충전 혜택
		if(amount == 10000){
			amount += 1000;
		}else if(amount == 20000){
			amount += 2500;
		}else if(amount == 50000){
			amount += 6000;
		}

		int userId = (int) request.getSession().getAttribute("userId");

		pntHistVO.setUserId(userId);
		pntHistVO.setChgQuty(amount);

		pointService.addCon(pntHistVO);

		int balance = pntHistVO.getBalance();

		pointService.updateUserCon(userId, balance);
	}
}
