package com.ncncn.controller;

import com.ncncn.domain.AdminSalesHistVO;
import com.ncncn.domain.AdminVisitrHistVO;
import com.ncncn.domain.StatisticsVO;
import com.ncncn.domain.response.AdminMainDTO;
import com.ncncn.service.GifticonService;
import com.ncncn.service.PsnlQustService;
import com.ncncn.service.StatisticsService;
import com.ncncn.service.UserService;
import lombok.extern.log4j.Log4j;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("/admin/*")
@Log4j
public class AdminMainController {

	private StatisticsService statisticsService;

	private UserService userService;

	private GifticonService gifticonService;

	private PsnlQustService psnlQustService;

	public AdminMainController(StatisticsService statisticsService, UserService userService, GifticonService gifticonService, PsnlQustService psnlQustService) {
		this.statisticsService = statisticsService;
		this.userService = userService;
		this.gifticonService = gifticonService;
		this.psnlQustService = psnlQustService;
	}

	@GetMapping("/main")
	public void getMain(HttpServletRequest request, Model model) {
		AdminMainDTO adminMainDTO;

		try {

			//금일 statistics 가져오기 - 없다면 init(0, 0)
			StatisticsVO stat = statisticsService.getByToday();

			//오늘 총 매출 update
			statisticsService.modifySalesRec(statisticsService.getByToday());

			log.info("금일 매출액 update 후  " + statisticsService.getByToday());

			//방문자 수 update
			stat.setVisitrRec((int)request.getSession().getAttribute("todayCount"));

			statisticsService.modifyVisitrRec(stat.getVisitrRec());

			log.info("금일 방문자 수 :" + stat.getVisitrRec());



			//main 그래프 데이터 읽어오기.
			adminMainDTO = new AdminMainDTO(
					statisticsService.getByToday(),
					userService.countRecentlyRegister(),
					gifticonService.countNotYetApproved(),
					psnlQustService.countHaveNoAns()
			);

			model.addAttribute("main", adminMainDTO);

		} catch (NullPointerException e) {
			model.addAttribute("error", e.getMessage());
		} catch (Exception e) {
			model.addAttribute("error", "통계 값 조회 중 문제가 발생했습니다.");
		}
	}

	//월별 매출 ajax
	@GetMapping(value = "/sales", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<AdminSalesHistVO>> getSalesByMonth(){

		try{
			List<AdminSalesHistVO> list = statisticsService.getSalesByMonth();
			log.info("list 값 : " + list);
			return new ResponseEntity<>(list, HttpStatus.OK);

		}catch (Exception e){
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}

	}

	//월별 방문자 수 ajax
	@GetMapping(value = "/visitr", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<AdminVisitrHistVO>> getVisitrByMonth(){

		try{
			List<AdminVisitrHistVO> list = statisticsService.getVisitrByMonth();
			log.info("list 값 : " + list);
			return new ResponseEntity<>(list, HttpStatus.OK);

		}catch (Exception e){
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}

	}

}
