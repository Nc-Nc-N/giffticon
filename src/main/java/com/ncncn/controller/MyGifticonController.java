package com.ncncn.controller;

import java.security.Principal;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.ncncn.domain.MyDealsVO;
import com.ncncn.domain.MySellVO;
import com.ncncn.domain.pagination.MyPageCriteria;
import com.ncncn.domain.pagination.PageDTO;
import com.ncncn.service.DealListService;
import com.ncncn.service.SellListService;
import com.ncncn.service.UserService;
import com.ncncn.service.WishListService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@Log4j
@RequestMapping("/user/mypage")
@AllArgsConstructor
public class MyGifticonController {

	private DealListService dealListService;
	private SellListService sellListService;
	private UserService userService;
	private WishListService wishService;

	@GetMapping("/deal")
	public void dealList(MyPageCriteria cri, Model model, HttpServletRequest request) {

		int userId = (int) request.getSession().getAttribute("userId");

		int total = dealListService.countDealList(userId, cri);

		model.addAttribute("dealList", dealListService.getDealsWithPaging(userId, cri));
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}

	@GetMapping("/dealDetail")
	public String dealDetail(HttpServletRequest request, int gftId, Model model,
							 @ModelAttribute("cri") MyPageCriteria cri) {

		log.info("dealDetail....");
		int userId = (int) request.getSession().getAttribute("userId");

		//로그인된 userId의 dealDetail을 가져오기 (url로 접속 방지)
		try {
			MyDealsVO gftInfo = dealListService.getGftDetail(gftId, userId);
			model.addAttribute("gftInfo", gftInfo);

		} catch (Exception e) { //다른 사용자의 dealDetail일 시 홈으로 이동시킴 (보안용)

			e.printStackTrace();
			log.info("다른 사용자의 조회페이지 입니다. 메인페이지로 이동합니다.");
			return "redirect:/user/home";
		}

		log.info("dealDetail로 이동합니다.");

		return "/user/mypage/dealDetail";
	}

	@GetMapping("/sells")
	public void SellList(HttpServletRequest request, @ModelAttribute("cri") MyPageCriteria cri, Model model) {

		int userId = (int) request.getSession().getAttribute("userId");

		int total = sellListService.countSellList(userId, cri);

		model.addAttribute("sellList", sellListService.getSellsWithPaging(userId, cri));
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}

	@GetMapping("/sellDetail")
	public String sellDetail(HttpServletRequest request, Model model,
							 @ModelAttribute("cri") MyPageCriteria cri, int gftId) {

		int userId = (int) request.getSession().getAttribute("userId");

		//로그인된 userId의 sellDetail을 가져오기 (url로 접속 방지)
		try {
			MySellVO gftInfo = sellListService.getSellDetail(gftId, userId);

			model.addAttribute("gftInfo", gftInfo);

		} catch (Exception e) { //다른 사용자의 sellDetail이면 홈으로 이동시킴 (보안용)

			log.info("다른 사용자의 조회페이지 입니다. 메인페이지로 이동합니다.");

			return "redirect:/user/home";
		}

		return "/user/mypage/sellDetail";
	}

	// 관심 상품
	@GetMapping("/wishList")
	public void wish(HttpServletRequest request, MyPageCriteria cri, Model model) {

		int userId = (int) request.getSession().getAttribute("userId");
		int total = wishService.getTotalCount(userId);
		log.info("wishList....");
		log.info("total: "+total);
		cri.setAmount(6);

		model.addAttribute("pageMaker", new PageDTO(cri, total));
		model.addAttribute("userId", userId);
		model.addAttribute("wishList", wishService.getWishListWithPaging(userId, cri));
	}

	@RequestMapping(value = "/absLoader", method = {RequestMethod.GET})
	public ResponseEntity<String> absLoader(@RequestParam("userId") int userId){

		//요약에 들어가면 모든 정보를 db에서 불러옴

		try {
			int stus004 = dealListService.countStus004(userId);
			int stus001 = sellListService.countStus001N002(userId, "판매대기");
			int stus002 = sellListService.countStus001N002(userId, "판매중");
			int userPnt = userService.readbyId(userId).getPnt();

			//String List로 변환
			String[] absList = {stus004+"", stus001+"", stus002+"", userPnt+""};

			//json을 변환
			Gson gson = new GsonBuilder().create();
			String absListJson = gson.toJson(absList);

			return new ResponseEntity<String>(absListJson, HttpStatus.OK);

		}catch (Exception e){

			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}


