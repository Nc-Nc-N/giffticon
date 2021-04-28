package com.ncncn.controller;

import com.ncncn.service.DealListService;
import com.ncncn.service.GifticonService;
import com.ncncn.service.WishListService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@Controller
@Log4j
@RequestMapping("/user/*")
@AllArgsConstructor
public class UserMainController {

	private WishListService wishService;
	private GifticonService giftiService;
	private DealListService dealListService;

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

	//메인 - 거래확정대기 수량 받아오기 (헤더 티켓아이콘)
	@RequestMapping(value = "/ticketAlarm",
					method= RequestMethod.GET)
	public ResponseEntity<Integer> ticketAlarm(@RequestParam("userId") int userId){

		try {
			int stus004 = dealListService.countStus004(userId);

			return new ResponseEntity<Integer>(stus004, HttpStatus.OK);
		}catch(Exception e){
			log.info("구매확정 티켓 수량 불러오기에 실패했습니다.");

			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

}
