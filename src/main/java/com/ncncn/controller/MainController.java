package com.ncncn.controller;

import com.ncncn.service.ProdService;
import com.ncncn.service.WishListService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@Log4j
@RequestMapping("/user/*")
@AllArgsConstructor
public class MainController {

	private WishListService wishService;
	private ProdService prodService;

	@GetMapping("/home")
	public void main(HttpServletRequest request, Model model){

		int userId = (int) request.getSession().getAttribute("userId");

		// 관심상품
		model.addAttribute("wishList", wishService.getWishList(userId));

		// 인기상품
		model.addAttribute("bestList", prodService.getBestGifti());

	}
}
