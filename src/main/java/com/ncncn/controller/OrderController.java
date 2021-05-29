package com.ncncn.controller;

import com.ncncn.domain.DealDetailVO;
import com.ncncn.domain.GifticonVO;
import com.ncncn.domain.UserInfoDTO;
import com.ncncn.service.DealListService;
import com.ncncn.service.GifticonService;
import com.ncncn.service.ProductService;
import com.ncncn.service.UserService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
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

	@RequestMapping(value = "/user/insertDeal", method = {RequestMethod.POST}, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<Integer> insertDeal(@RequestBody DealDetailVO dealDetailVO, HttpServletRequest request){

		int userId = (int) request.getSession().getAttribute("userId");
		dealDetailVO.setUserId(userId);

		// deal_detail 추가
		try{
			return new ResponseEntity<>(dealService.insertDeal(dealDetailVO), HttpStatus.OK);

		}catch (Exception e){
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
	}

	@PostMapping("/payment_cmplt")
	public String paymentCmplt(int gftId, int dcPrc, String prodCode, HttpServletRequest request, Model model){

		try{
			int userId = (int) request.getSession().getAttribute("userId");
			UserInfoDTO user = userService.getMyInfo(userId);

			// 기프티콘 상태 변경
			giftiService.updateGftStus(gftId);

			// 상품 sold_quty 변경
			productService.updateSoldQuty(gftId);

			model.addAttribute("prodCode", prodCode);
			model.addAttribute("gftId", gftId);
			model.addAttribute("dcPrc", dcPrc);
			model.addAttribute("user", user);

		}catch (Exception e){
			model.addAttribute("error", "일시적인 오류가 생겨 잠시 후 다시 시도해주시기 바랍니다.");

		}

		return "user/gifticon/payment_cmplt";
	}

	@GetMapping("/checkValidGft/{gftId}/{dcPrcVal}")
	public ResponseEntity<String> checkValidGft(@PathVariable("gftId") int gftId, @PathVariable("dcPrcVal") int dcPrcVal){


		GifticonVO gifticonVO = giftiService.checkValidPrc(gftId,dcPrcVal);

		if(gifticonVO == null || gifticonVO.getGftStusCode().equals("003")){
			return new ResponseEntity(HttpStatus.NO_CONTENT);
		}else{
			if(gifticonVO.getDcPrc() == dcPrcVal){
				return new ResponseEntity(HttpStatus.OK);
			}else{
				return new ResponseEntity(HttpStatus.EXPECTATION_FAILED);
			}
		}

	}

}
