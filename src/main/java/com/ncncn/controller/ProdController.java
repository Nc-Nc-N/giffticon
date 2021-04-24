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

@Controller
@Log4j
@RequestMapping("/user/*")
@AllArgsConstructor
public class ProdController {

	private CategoryService cateService;
	private BrandService brandService;
	private GifticonService giftiService;
	private WishListService wishService;

	// 기프티콘 목록 페이지
	@GetMapping(value = "/prod_list")
	public String prodList(GiftiCriteria cri, Model model){

		String code = cri.getCode();
		int total = giftiService.getTotal(cri);

		// code 값이 정수인지 판별
		if(isInteger(code) || code==null){
			try {

				model.addAttribute("category", cateService.getCate(code));            	// 카테고리
				model.addAttribute("brandList", brandService.getBrdList(code));    	// 브랜드 목록
				model.addAttribute("gifti", giftiService.getGiftiWithPaging(cri));    	// 기프티콘 목록(페이징 처리 포함)
				model.addAttribute("headerPageMaker", new PageDTO(cri, total));


				return "/user/prod_list";

			} catch (Exception e) {
				model.addAttribute("error", "상품 조회 중 문제가 발생했습니다.");
				return "/user/prod_list";
			}
		}
		else{	// code에 숫자가 아닌 다른 문자가 들어갔을 때
			model.addAttribute("error", "상품 조회 중 문제가 발생했습니다.");
			return "redirect:/user/prod_list?code=0";
		}
	}


	// 기프티콘 상세 페이지
	@GetMapping(value = "/prod_detail")
	public String prodDetail(HttpServletRequest request, GiftiCriteria cri, WishListVO wish, Model model){

		String code = cri.getCode();
		int total = giftiService.getTotal(cri);
		int hasWish = 0;
		int userId = 0;

		try{						// 로그인이 되어 있을 때
			userId = (int) request.getSession().getAttribute("userId");
			wish.setProdCode(code);
			wish.setUserId(userId);

			hasWish = wishService.hasWish(wish);

		}catch (Exception e){ 		// 로그인이 안 되어 있을 때
			hasWish = 0;
			userId = 0;
		}

		// code 값이 정수인지 판별
		if(isInteger(code) || code==null){
			try {
				model.addAttribute("category", cateService.getCate(code));				// 카테고리
				model.addAttribute("brandList", brandService.getBrdList(code));		// 브랜드 목록
				model.addAttribute("giftiList", giftiService.getGiftiList(code));		// 등록된 기프티콘 목록
				model.addAttribute("gifticon", giftiService.getGifti(code));				// 대표 기프티콘
				model.addAttribute("userId", userId);									// 로그인한 사용자 userId
				model.addAttribute("hasWish", wishService.hasWish(wish));				// 관심상품에 등록되어 있는지(있으면 1, 없으면 0)

				return "/user/prod_detail";

			}catch (Exception e){
				model.addAttribute("error", "상품 조회 중 문제가 발생했습니다.");
				return "/user/prod_detail";
			}
		}
		else {	// code에 숫자가 아닌 다른 문자가 들어갔을 때
			model.addAttribute("error", "상품 조회 중 문제가 발생했습니다.");
			return "redirect:/user/prod_list?code=0";
		}

	}

	//정수 판별 함수
	static boolean isInteger(String s) {
		try {
			Integer.parseInt(s);
			return true;

		} catch(NumberFormatException e) {  //문자열이 나타내는 숫자와 일치하지 않는 타입의 숫자로 변환 시 발생
			return false;
		}
	}
}