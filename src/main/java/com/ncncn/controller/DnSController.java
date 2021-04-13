package com.ncncn.controller;

import com.ncncn.domain.CriteriaSM;
import com.ncncn.domain.MyDealsDTO;
import com.ncncn.domain.PageDTOSM;
import com.ncncn.service.DealListService;
import com.ncncn.service.UserCheckService;
import com.ncncn.service.UserService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.security.Principal;

@Controller
@Log4j
@RequestMapping("/user/mypage")
@AllArgsConstructor
public class DnSController {

    private DealListService dealListService;
    private UserCheckService userCheckService;
    private UserService userService;

    @GetMapping("/deal")
    public void dealList(Principal principal, CriteriaSM cri, Model model, HttpServletRequest request) {


        String email = principal.getName();
        int userId = (int) request.getSession().getAttribute("userId");

        int total = dealListService.countDealList(email, cri);

        log.info("service done at controller");
        log.info("email: " + principal.getName());
        log.info("keyword: " + cri.getKeyword());
        log.info("type : " + cri.getType());
        log.info("dateFrom : " + cri.getDateFrom());
        log.info("dateTo : " + cri.getDateTo());

        model.addAttribute("countStus004", dealListService.countStus004(userId));
        model.addAttribute("countStus001", dealListService.countStus001N002(userId, "판매대기"));
        model.addAttribute("countStus002", dealListService.countStus001N002(userId, "판매중"));
        model.addAttribute("userPnt", userService.readbyId(userId).getPnt());
        model.addAttribute("dealList", dealListService.getDealsWithPaging(email, cri));
        model.addAttribute("pageMaker", new PageDTOSM(cri, total));

        log.info("deals loading....");
    }

    @GetMapping("/dealDetail")
    public void dealDetail(HttpServletRequest request, Principal principal, int gftId, Model model,
                           @ModelAttribute("cri") CriteriaSM cri)
            throws IOException {

        int userId = (int) request.getSession().getAttribute("userId");

        MyDealsDTO gftInfo = dealListService.getGftDetail(gftId).get(0);

        log.info("Get Detail of gftId: " + gftId);
        log.info("user Email: " + principal.getName());
        log.info("gftInfo: " + gftInfo.toString());

        model.addAttribute("countStus004", dealListService.countStus004(userId));
        model.addAttribute("countStus001", dealListService.countStus001N002(userId, "판매대기"));
        model.addAttribute("countStus002", dealListService.countStus001N002(userId, "판매중"));
        model.addAttribute("userPnt", userService.readbyId(userId).getPnt());
        model.addAttribute("gftInfo", gftInfo);
    }
}
