package com.ncncn.controller;

import com.ncncn.domain.WishListVO;
import com.ncncn.domain.pagination.GiftiCriteria;
import com.ncncn.domain.pagination.PageDTO;
import com.ncncn.service.BrandService;
import com.ncncn.service.CategoryService;
import com.ncncn.service.GifticonService;
import com.ncncn.service.WishListService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/user/*")
@AllArgsConstructor
public class ProdController {

	private CategoryService cateService;

	private BrandService brandService;

	private GifticonService giftiService;

	private WishListService wishService;

	// 기프티콘 목록 페이지
	@GetMapping(value = "/gifti_list")
	public String giftiList(GiftiCriteria cri, Model model){

		String code = cri.getCode();
		int total = giftiService.getTotal(cri);

		try {

			model.addAttribute("category", cateService.getCate(code));            	// 카테고리
			model.addAttribute("brandList", brandService.getBrdList(code));    		// 브랜드 목록
			model.addAttribute("gifti", giftiService.getGiftiWithPaging(cri));    	// 기프티콘 목록(페이징 처리 포함)
			model.addAttribute("headerPageMaker", new PageDTO(cri, total));

			return "/user/gifticon/gifti_list";

		} catch (Exception e) {
			model.addAttribute("error", "상품 조회 중 문제가 발생했습니다.");
			return "/user/gifticon/gifti_list";
		}
	}


	// 기프티콘 상세 페이지
	@GetMapping(value = "/gifti_detail")
	public String giftiDetail(HttpServletRequest request, GiftiCriteria cri, WishListVO wish, Model model){

		String code = cri.getCode();
		int total = giftiService.getTotal(cri);
		int hasWish = 0;
		Integer userId = null;

		userId = (Integer) request.getSession().getAttribute("userId");

		if(userId != null){			// 로그인이 되어 있을 때

			wish.setProdCode(code);
			wish.setUserId(userId);

			hasWish = wishService.hasWish(wish);
		}else{
			userId = 0;
		}

		try {
			model.addAttribute("category", cateService.getCate(code));				// 카테고리
			model.addAttribute("brandList", brandService.getBrdList(code));			// 브랜드 목록
			model.addAttribute("giftiList", giftiService.getGiftiList(code));		// 등록된 기프티콘 목록
			model.addAttribute("gifticon", giftiService.getGifti(code));				// 대표 기프티콘
			model.addAttribute("userId", userId);									// 로그인한 사용자 userId
			model.addAttribute("hasWish", hasWish);									// 관심상품에 등록되어 있는지(있으면 1, 없으면 0)

			return "/user/gifticon/gifti_detail";

		}catch (Exception e){ 
			model.addAttribute("error", "상품 조회 중 문제가 발생했습니다.");
			return "/user/gifticon/gifti_detail";
		}
	}
}