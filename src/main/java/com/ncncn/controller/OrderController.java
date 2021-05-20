package com.ncncn.controller;

import com.ncncn.domain.UserInfoDTO;
import com.ncncn.mapper.DealListMapper;
import com.ncncn.service.DealListService;
import com.ncncn.service.GifticonService;
import com.ncncn.service.ProductService;
import com.ncncn.service.UserService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@Controller
@AllArgsConstructor
@Log4j
public class OrderController {

	private GifticonService giftiService;
	private UserService userService;
	private DealListService dealService;
	private ProductService productService;

	@GetMapping("/user/gifti_order")
	public String giftiOrder(@RequestParam("gifti") int id, HttpServletRequest request,  Model model) {


		try{
			int userId = (int) request.getSession().getAttribute("userId");
			UserInfoDTO user = userService.getMyInfo(userId);

			model.addAttribute("gifticon", giftiService.getGifticon(id));
			model.addAttribute("user", user);

		}catch (Exception e){
			model.addAttribute("error", "일시적인 오류가 생겨 잠시 후 다시 시도해주시기 바랍니다.");
		}
		return "user/gifticon/gifti_order";
	}

	@PostMapping("/payment_cmplt")
	public String paymentCmplt(int gftId, int dcPrc, String metdStus, HttpServletRequest request, Model model){

		log.info("gft_id: "+gftId);
		log.info("metdStus: "+metdStus);


		try{
			int userId = (int) request.getSession().getAttribute("userId");
			UserInfoDTO user = userService.getMyInfo(userId);

			// 기프티콘 상태 변경
			giftiService.updateGftStus(gftId);

			// deal_detail 추가
			dealService.insertDeal(userId,gftId, dcPrc, metdStus);

			// 상품 sold_quty 변경
			productService.updateSoldQuty(gftId);

			model.addAttribute("gftId", gftId);
			model.addAttribute("dcPrc", dcPrc);
			model.addAttribute("user", user);

		}catch (Exception e){
			model.addAttribute("error", "일시적인 오류가 생겨 잠시 후 다시 시도해주시기 바랍니다.");

		}

		return "user/gifticon/payment_cmplt";
	}
}
