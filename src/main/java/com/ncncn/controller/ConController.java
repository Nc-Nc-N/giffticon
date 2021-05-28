package com.ncncn.controller;

import com.ncncn.domain.PntHistVO;
import com.ncncn.domain.UserInfoDTO;
import com.ncncn.domain.pagination.MyPageCriteria;
import com.ncncn.domain.pagination.PageDTO;
import com.ncncn.service.ConService;
import com.ncncn.service.UserService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/user/*")
@Log4j
@AllArgsConstructor
public class ConController {

	private UserService userService;
	private ConService conService;

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
	@ResponseBody
	public void addCon(@RequestBody PntHistVO pntHistVO, HttpServletRequest request) {

		log.info("conUpdate....");

		// 충전할 때
		if(pntHistVO.getPntHistCode().equals("001")){

			int amount = pntHistVO.getChgQuty();
			// 콘 충전 혜택
			if (amount == 10000) {
				amount += 1000;
			} else if (amount == 20000) {
				amount += 2500;
			} else if (amount == 50000) {
				amount += 6000;
			}
			pntHistVO.setChgQuty(amount);
		}

		int userId = (int) request.getSession().getAttribute("userId");
		pntHistVO.setUserId(userId);

		// conHist insert
		conService.insertConHist(pntHistVO);

		//사용자 콘 update
		int balance = pntHistVO.getBalance();
		conService.updateUserCon(userId, balance);
	}

	@GetMapping("/mypage/myCon")
	public void myCon(HttpServletRequest request, Model model, MyPageCriteria cri){

		int userId = (int) request.getSession().getAttribute("userId");

		UserInfoDTO user = userService.getMyInfo(userId);
		int total = conService.getConTotal(userId, cri);
		cri.setAmount(10);

		try{
			model.addAttribute("user", user);
			model.addAttribute("conHist", conService.getConHistWithPaging(userId, cri));
			model.addAttribute("pageMaker", new PageDTO(cri, total));
		}catch (Exception e){
			model.addAttribute("error", "일시적인 오류가 생겨 잠시 후 다시 시도해주시기 바랍니다.");
		}

	}

	@GetMapping("/mypage/withdrawCon")
	public String withdrawCon(HttpServletRequest request, Model model){

		int userId = (int) request.getSession().getAttribute("userId");

		try{
			UserInfoDTO user = userService.getMyInfo(userId);
			model.addAttribute("user", user);

			if(user.getAcc() == null){
				throw new NullPointerException("등록된 계좌가 없습니다.");
			}

		}catch (Exception e){
			model.addAttribute("error", "일시적인 오류가 생겨 잠시 후 다시 시도해주시기 바랍니다.");
			return "redirect:/user/home";
		}

		return "/user/mypage/withdrawCon";
	}

}
