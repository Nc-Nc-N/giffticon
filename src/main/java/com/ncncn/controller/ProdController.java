package com.ncncn.controller;

import com.ncncn.domain.GiftiCriteria;
import com.ncncn.domain.PageDTOHY;
import com.ncncn.domain.WishListVO;
import com.ncncn.security.CustomUserDetailsService;
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
public class ProdController {

	private ProdService prodService;
	private WishListService wishService;

	// 기프티콘 목록 페이지
	@GetMapping(value = "/prod_list")
	public void prodList(GiftiCriteria cri, Model model){

		String code = cri.getCode();
		int total = prodService.getTotal(cri);

		try {
			model.addAttribute("category", prodService.getCate(code));            // 카테고리
			model.addAttribute("brandList", prodService.getBrandList(code));    	// 브랜드 목록
			model.addAttribute("gifti", prodService.getGiftiWithPaging(cri));    // 기프티콘 목록(페이징 처리 포함)
			model.addAttribute("headerPageMaker", new PageDTOHY(cri, total));

		} catch (Exception e) {
			model.addAttribute("error", "상품 조회 중 문제가 발생했습니다.");
		}
	}


	// 기프티콘 상세 페이지
	@GetMapping(value = "/prod_detail")
	public void prodDetail(HttpServletRequest request, GiftiCriteria cri, WishListVO wish, Model model){

		String code = cri.getCode();
		int total = prodService.getTotal(cri);
		int hasWish = 0;
		int userId = 0;

		try{	// 로그인이 되어 있을 때
			userId = (int) request.getSession().getAttribute("userId");
			wish.setProdCode(code);
			wish.setUserId(userId);

			hasWish = wishService.hasWish(wish);
		}catch (Exception e){ 		// 로그인이 안 되어 있을 때
			hasWish = 0;
			userId = 0;
		}

		try {
			model.addAttribute("category", prodService.getCate(code));			// 카테고리
			model.addAttribute("brandList", prodService.getBrandList(code));		// 브랜드 목록
			model.addAttribute("giftiList", prodService.getGiftiList(code));		// 등록된 기프티콘 목록
			model.addAttribute("pageMaker", new PageDTOHY(cri, total)); 			// 카테고리바에서 prod_list로 이동시 필요
			model.addAttribute("gifticon", prodService.getGifti(code));			// 대표 기프티콘
			model.addAttribute("userId", userId);								// 로그인한 사용자 userId
			model.addAttribute("hasWish", wishService.hasWish(wish));			// 관심상품에 등록되어 있는지(있으면 1, 없으면 0)

		}catch (Exception e){
			model.addAttribute("error", "상품 조회 중 문제가 발생했습니다.");
		}
	}
}

