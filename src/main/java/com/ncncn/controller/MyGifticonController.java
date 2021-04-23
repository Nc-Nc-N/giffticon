package com.ncncn.controller;

import java.security.Principal;
import javax.servlet.http.HttpServletRequest;

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

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

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
	public void dealList(Principal principal, MyPageCriteria cri, Model model, HttpServletRequest request) {

		int userId = (int) request.getSession().getAttribute("userId");

		int total = dealListService.countDealList(userId, cri);

		model.addAttribute("countStus004", dealListService.countStus004(userId));
		model.addAttribute("countStus001", sellListService.countStus001N002(userId, "판매대기"));
		model.addAttribute("countStus002", sellListService.countStus001N002(userId, "판매중"));
		model.addAttribute("userPnt", userService.readbyId(userId).getPnt());
		model.addAttribute("dealList", dealListService.getDealsWithPaging(userId, cri));
		model.addAttribute("pageMaker", new PageDTO(cri, total));

		log.info("deals loading....");
	}

	@GetMapping("/dealDetail")
	public String dealDetail(HttpServletRequest request, int gftId, Model model,
							 @ModelAttribute("cri") MyPageCriteria cri) {

		int userId = (int) request.getSession().getAttribute("userId");

		try {
			MyDealsVO gftInfo = dealListService.getGftDetail(gftId, userId).get(0);
			model.addAttribute("gftInfo", gftInfo);

		} catch (Exception e) { //다른 사용자의 dealDetail일 시 홈으로 이동시킴 (보안용)

			e.printStackTrace();
			log.info("다른 사용자의 조회페이지 입니다. 메인페이지로 이동합니다.");
			return "redirect:/user/home";
		}

		log.info("Get Detail of gftId: " + gftId);

		model.addAttribute("countStus004", dealListService.countStus004(userId));
		model.addAttribute("countStus001", sellListService.countStus001N002(userId, "판매대기"));
		model.addAttribute("countStus002", sellListService.countStus001N002(userId, "판매중"));
		model.addAttribute("userPnt", userService.readbyId(userId).getPnt());

		return "/user/mypage/dealDetail";
	}

	@GetMapping("/sells")
	public void SellList(HttpServletRequest request, MyPageCriteria cri, Model model) {

		int userId = (int) request.getSession().getAttribute("userId");

		int total = sellListService.countSellList(userId, cri);

		model.addAttribute("countStus004", dealListService.countStus004(userId));
		model.addAttribute("countStus001", sellListService.countStus001N002(userId, "판매대기"));
		model.addAttribute("countStus002", sellListService.countStus001N002(userId, "판매중"));
		model.addAttribute("userPnt", userService.readbyId(userId).getPnt());
		model.addAttribute("sellList", sellListService.getSellsWithPaging(userId, cri));
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}

	@GetMapping("/sellDetail")
	public String sellDetail(HttpServletRequest request, Model model,
							 @ModelAttribute("cri") MyPageCriteria cri, int gftId,
							 Principal principal) {

		int userId = (int) request.getSession().getAttribute("userId");

		try {
			MySellVO gftInfo = sellListService.getSellDetail(gftId, userId).get(0);

			log.info("gftINfo autoPRC : " + gftInfo.getIsAutoPrc());
			model.addAttribute("gftInfo", gftInfo);
		} catch (Exception e) { //다른 사용자의 sellDetail이면 홈으로 이동시킴 (보안용)
			e.printStackTrace();
			log.info("다른 사용자의 조회페이지 입니다. 메인페이지로 이동합니다.");

			return "redirect:/user/home";
		}

		model.addAttribute("countStus004", dealListService.countStus004(userId));
		model.addAttribute("countStus001", sellListService.countStus001N002(userId, "판매대기"));
		model.addAttribute("countStus002", sellListService.countStus001N002(userId, "판매중"));
		model.addAttribute("userPnt", userService.readbyId(userId).getPnt());
		model.addAttribute("principal", principal);
		return "/user/mypage/sellDetail";

	}

	// 관심 상품
	@GetMapping("/wishList")
	public void wish(HttpServletRequest request, MyPageCriteria cri, Model model) {

		int userId = (int) request.getSession().getAttribute("userId");
		int total = wishService.getTotalCount(userId);

		model.addAttribute("countStus004", dealListService.countStus004(userId));
		model.addAttribute("countStus001", sellListService.countStus001N002(userId, "판매대기"));
		model.addAttribute("countStus002", sellListService.countStus001N002(userId, "판매중"));
		model.addAttribute("userPnt", userService.readbyId(userId).getPnt());
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		model.addAttribute("userId", userId);
		model.addAttribute("wishList", wishService.getWishListWithPaging(userId, cri));
	}
}
