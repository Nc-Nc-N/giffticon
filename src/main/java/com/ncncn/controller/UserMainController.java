package com.ncncn.controller;

import com.ncncn.domain.BrandVO;
import com.ncncn.domain.CategoryVO;
import com.ncncn.service.BrandService;
import com.ncncn.service.CategoryService;
import com.ncncn.service.GifticonService;
import com.ncncn.service.WishListService;
import lombok.AllArgsConstructor;
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
