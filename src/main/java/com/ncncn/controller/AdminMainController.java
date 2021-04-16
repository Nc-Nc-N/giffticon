package com.ncncn.controller;

import com.ncncn.domain.response.AdminMainDTO;
import com.ncncn.service.CsPsnlQustService;
import com.ncncn.service.GifticonService;
import com.ncncn.service.StatisticsService;
import com.ncncn.service.UserService;
import lombok.extern.log4j.Log4j;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/*")
@Log4j
public class AdminMainController {

	private StatisticsService statisticsService;

	private UserService userService;

	private GifticonService gifticonService;

	private CsPsnlQustService csPsnlQustService;

	public AdminMainController(StatisticsService statisticsService, UserService userService, GifticonService gifticonService, CsPsnlQustService csPsnlQustService) {
		this.statisticsService = statisticsService;
		this.userService = userService;
		this.gifticonService = gifticonService;
		this.csPsnlQustService = csPsnlQustService;
	}

	@GetMapping("/main")
	public void getMain(Model model) {
		AdminMainDTO adminMainDTO;

		try {
			adminMainDTO = new AdminMainDTO(
					statisticsService.getByToday(),
					userService.countRecentlyRegister(),
					gifticonService.countNotYetApproved(),
					csPsnlQustService.countHaveNoAns()
			);

			model.addAttribute("main", adminMainDTO);

		} catch (NullPointerException e) {
			model.addAttribute("error", e.getMessage());
		} catch (Exception e) {
			model.addAttribute("error", "통계 값 조회 중 문제가 발생했습니다.");
		}
	}
}
