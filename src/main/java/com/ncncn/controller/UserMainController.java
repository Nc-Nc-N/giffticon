package com.ncncn.controller;


import com.ncncn.service.DealListService;

import com.ncncn.domain.BrandVO;
import com.ncncn.domain.CategoryVO;
import com.ncncn.service.BrandService;
import com.ncncn.service.CategoryService;

import com.ncncn.service.GifticonService;
import com.ncncn.service.WishListService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;

import org.springframework.http.MediaType;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.net.URLDecoder;
import java.util.List;

@Controller
@RequestMapping("/user/*")
@AllArgsConstructor
public class UserMainController {

	private CategoryService cateService;

	private BrandService brandService;

	private GifticonService giftiService;

	private WishListService wishService;

  private DealListService dealListService;

	@GetMapping("/home")
	public void main(HttpServletRequest request, Model model){

		Integer userId = (Integer) request.getSession().getAttribute("userId");

		if(userId == null){
            model.addAttribute("notice", "로그인 후에 이용 가능한 메뉴입니다.");

		}else {
			try {
				model.addAttribute("wishList", wishService.getWishList(userId));			// 관심상품

			}catch (Exception e) {
				model.addAttribute("error", "상품 조회 중 문제가 발생했습니다.");
			}
		}

		try{
			model.addAttribute("bestList", giftiService.getBestGifti());				// 인기상품
			model.addAttribute("deadlineList", giftiService.getDeadlineGifti());		// 마감상품

		}catch (Exception e){
			model.addAttribute("error", "상품 조회 중 문제가 발생했습니다.");
		}
	}

  //메인 - 거래확정대기 수량 받아오기 (헤더 티켓아이콘)
  @RequestMapping(value = "/ticketAlarm",
          method = RequestMethod.GET)
  public ResponseEntity<Integer> ticketAlarm(@RequestParam("userId") int userId) {

      try {
          int stus004 = dealListService.countStus004(userId);

          return new ResponseEntity<Integer>(stus004, HttpStatus.OK);
      } catch (Exception e) {
          log.info("구매확정 티켓 수량 불러오기에 실패했습니다.");

          return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
      }
  }

	

	@RequestMapping(value = "/menuLoader", method = {RequestMethod.GET}, produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<CategoryVO>> menuLoader(){

		try{
			List<CategoryVO> cateList = cateService.getCategoryList();

			return new ResponseEntity<>(cateList, HttpStatus.OK);

		}catch (Exception e){

			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@RequestMapping(value = "/getBrand", method = {RequestMethod.GET}, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<BrandVO>> getBrandList(@RequestParam("name") String name){

		try{
			String cateName = URLDecoder.decode(name, "UTF-8");
			List<BrandVO> brdList = brandService.getBrandList(cateName);

			return new ResponseEntity<>(brdList, HttpStatus.OK);

		}catch (Exception e){

			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

}
