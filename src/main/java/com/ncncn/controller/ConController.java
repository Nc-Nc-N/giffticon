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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/user/*")
@Log4j
@AllArgsConstructor
public class ConController {

	private UserService userService;
	private ConService pointService;

	// 콘 충전하기 페이지
	@GetMapping(value = "/mypage/addCon")
	public void addConPage(HttpServletRequest request, Model model) {

		int userId = (int) request.getSession().getAttribute("userId");

		UserInfoDTO user = userService.getMyInfo(userId);

		try{
			model.addAttribute("email", user.getEmail());
			model.addAttribute("name", user.getName());
			model.addAttribute("tel", user.getTelNo());
			model.addAttribute("userCon", user.getPnt());

		}catch (Exception e){
			model.addAttribute("error", "일시적인 오류가 생겨 잠시 후 다시 시도해주시기 바랍니다.");
		}

	}

	// conHist insert, 사용자 보유 콘 update
	@PostMapping("/conUpdate")
	public @ResponseBody
	void addCon(int amount, String pntCode, PntHistVO pntHistVO, HttpServletRequest request) {

		log.info("amount: "+amount);
		log.info("pntCode: "+pntCode);

		if(pntCode.equals("001")){
			// 콘 충전 혜택
			if (amount == 10000) {
				amount += 1000;
			} else if (amount == 20000) {
				amount += 2500;
			} else if (amount == 50000) {
				amount += 6000;
			}
		}

		int userId = (int) request.getSession().getAttribute("userId");

		pntHistVO.setUserId(userId);
		pntHistVO.setChgQuty(amount);
		pntHistVO.setPntHistCode(pntCode);

		// conHist insert
		pointService.insertConHist(pntHistVO);

		//사용자 콘 update
		int balance = pntHistVO.getBalance();
		pointService.updateUserCon(userId, balance);
	}

	@GetMapping("/mypage/myCon")
	public void myCon(){

	}

	@GetMapping("/mypage/withdrawCon")
	public void withdrawCon(HttpServletRequest request, Model model){

		int userId = (int) request.getSession().getAttribute("userId");

		UserInfoDTO user = userService.getMyInfo(userId);

		try{
			model.addAttribute("user", user);

		}catch (Exception e){
			model.addAttribute("error", "일시적인 오류가 생겨 잠시 후 다시 시도해주시기 바랍니다.");
		}
	}

}
