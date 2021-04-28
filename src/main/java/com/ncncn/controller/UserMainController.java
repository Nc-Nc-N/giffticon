package com.ncncn.controller;

import com.ncncn.service.GifticonService;
import com.ncncn.service.WishListService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/user/*")
@AllArgsConstructor
public class UserMainController {

	private WishListService wishService;
	private GifticonService giftiService;

	@GetMapping("/home")
	public void main(HttpServletRequest request, Model model){

		try {						// 로그인 되어 있을 때
			int userId = (int) request.getSession().getAttribute("userId");
			model.addAttribute("wishList", wishService.getWishList(userId));

		} catch (Exception e){		// 로그인 안 되어 있을 때
			model.addAttribute("notice", "로그인 후에 이용 가능한 메뉴입니다.");
		}
		// 인기상품
		model.addAttribute("bestList", giftiService.getBestGifti());

		// 마감상품
		model.addAttribute("deadlineList", giftiService.getDeadlineGifti());

	}
}
