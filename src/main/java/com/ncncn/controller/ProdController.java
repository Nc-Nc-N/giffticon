package com.ncncn.controller;

import com.ncncn.domain.GiftiCriteria;
import com.ncncn.domain.PageDTOHY;
import com.ncncn.domain.WishListVO;
import com.ncncn.service.ProdService;
import com.ncncn.service.WishListService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import sun.tools.jconsole.JConsole;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
@Log4j
@RequestMapping("/user/*")
@AllArgsConstructor
public class ProdController {

	private ProdService prodService;
	private WishListService wishService;
	// 기프티콘 목록 페이지
	@GetMapping(value = "/prod_list")
	public String prodList(GiftiCriteria cri, Model model){

		String code = cri.getCode();
		int total = prodService.getTotal(cri);

		if(isInteger(code) || code==null){
			try {
				model.addAttribute("category", prodService.getCate(code));            // 카테고리
				model.addAttribute("brandList", prodService.getBrandList(code));    // 브랜드 목록
				model.addAttribute("gifti", prodService.getGiftiWithPaging(cri));    // 기프티콘 목록(페이징 처리 포함)
				model.addAttribute("headerPageMaker", new PageDTOHY(cri, total));

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
		int total = prodService.getTotal(cri);
		int userId = (int) request.getSession().getAttribute("userId");

		wish.setUserId(userId);
		wish.setProdCode(code);

		if(isInteger(code) || code==null){
			try {
				model.addAttribute("category", prodService.getCate(code));			// 카테고리
				model.addAttribute("brandList", prodService.getBrandList(code));		// 브랜드 목록
				model.addAttribute("giftiList", prodService.getGiftiList(code));		// 등록된 기프티콘 목록
				model.addAttribute("pageMaker", new PageDTOHY(cri, total)); 			// 카테고리바에서 prod_list로 이동시 필요
				model.addAttribute("gifticon", prodService.getGifti(code));			// 대표 기프티콘
				model.addAttribute("userId", userId);								// 로그인한 사용자 userId
				model.addAttribute("hasWish", wishService.hasWish(wish));			// 관심상품에 등록되어 있는지(있으면 1, 없으면 0)

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

	static boolean isInteger(String s) { //정수 판별 함수
		try {
			Integer.parseInt(s);
			return true;

		} catch(NumberFormatException e) {  //문자열이 나타내는 숫자와 일치하지 않는 타입의 숫자로 변환 시 발생
			return false;
		}
	}
}

