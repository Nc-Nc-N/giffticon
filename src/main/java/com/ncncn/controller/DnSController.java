package com.ncncn.controller;

import com.ncncn.domain.CriteriaSM;
import com.ncncn.domain.MyDealsDTO;
import com.ncncn.domain.MySellDTO;
import com.ncncn.domain.PageDTOSM;
import com.ncncn.service.DealListService;
import com.ncncn.service.SellListService;
import com.ncncn.service.UserCheckService;
import com.ncncn.service.UserService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.Principal;

@Controller
@Log4j
@RequestMapping("/user/mypage")
@AllArgsConstructor
public class DnSController {

    private DealListService dealListService;
    private SellListService sellListService;
    private UserCheckService userCheckService;
    private UserService userService;

    @GetMapping("/deal")
    public void dealList(Principal principal, CriteriaSM cri, Model model, HttpServletRequest request) {

        int userId = (int) request.getSession().getAttribute("userId");

        int total = dealListService.countDealList(userId, cri);

        log.info("service done at controller");
        log.info("email: " + principal.getName());
        log.info("keyword: " + cri.getKeyword());
        log.info("type : " + cri.getType());
        log.info("dateFrom : " + cri.getDateFrom());
        log.info("dateTo : " + cri.getDateTo());

        model.addAttribute("countStus004", dealListService.countStus004(userId));
        model.addAttribute("countStus001", sellListService.countStus001N002(userId, "판매대기"));
        model.addAttribute("countStus002", sellListService.countStus001N002(userId, "판매중"));
        model.addAttribute("userPnt", userService.readbyId(userId).getPnt());
        model.addAttribute("dealList", dealListService.getDealsWithPaging(userId, cri));
        model.addAttribute("pageMaker", new PageDTOSM(cri, total));

        log.info("deals loading....");
    }

    @GetMapping("/dealDetail")
    public String dealDetail(HttpServletRequest request, int gftId, Model model,
                           @ModelAttribute("cri") CriteriaSM cri)
            throws IOException {

        int userId = (int) request.getSession().getAttribute("userId");

        try {
            MyDealsDTO gftInfo = dealListService.getGftDetail(gftId, userId).get(0);
            model.addAttribute("gftInfo", gftInfo);

        }catch (Exception e){

            e.printStackTrace();
            log.info("다른 사용자의 조회페이지 입니다. 메인페이지로 이동합니다.");
            return "redirect:/user/home";
        }

        log.info("Get Detail of gftId: " + gftId);

        model.addAttribute("countStus004", dealListService.countStus004(userId));
        model.addAttribute("countStus001", sellListService.countStus001N002(userId, "판매대기"));
        model.addAttribute("countStus002", sellListService.countStus001N002(userId, "판매중"));
        model.addAttribute("userPnt", userService.readbyId(userId).getPnt());

        return "/user/mypage/dealDetail";
    }

    @GetMapping("/sells")
    public void SellList(HttpServletRequest request, CriteriaSM cri, Model model){

        int userId = (int) request.getSession().getAttribute("userId");
        int total = sellListService.countSellList(userId, cri);
        log.info("loading Sell List Controller...");

        model.addAttribute("countStus004", dealListService.countStus004(userId));
        model.addAttribute("countStus001", sellListService.countStus001N002(userId, "판매대기"));
        model.addAttribute("countStus002", sellListService.countStus001N002(userId, "판매중"));
        model.addAttribute("userPnt", userService.readbyId(userId).getPnt());
        model.addAttribute("sellList", sellListService.getSellsWithPaging(userId, cri));
        model.addAttribute("pageMaker", new PageDTOSM(cri, total));


        // deal Controller는 완료 sellList는 되돌리기기
    }

    @GetMapping("/sellDetail")
    public String sellDetail(HttpServletRequest request,  Model model,
                           @ModelAttribute("cri") CriteriaSM cri, Principal principal)
            throws IOException {

        int gftId = 94;
        log.info("!!!!!gftId: " + gftId);
        int userId = (int)request.getSession().getAttribute("userId");

        try {
            MySellDTO gftInfo = sellListService.getSellDetail(gftId, userId).get(0);

            log.info("gftINfo autoPRC : " + gftInfo.getIsAutoPrc());
            model.addAttribute("gftInfo", gftInfo);
        }catch (Exception e){
            e.printStackTrace();
            log.info("다른 사용자의 조회페이지 입니다. 메인페이지로 이동합니다.");

            return "redirect:/user/home";
        }

        model.addAttribute("countStus004", dealListService.countStus004(userId));
        model.addAttribute("countStus001", sellListService.countStus001N002(userId, "판매대기"));
        model.addAttribute("countStus002", sellListService.countStus001N002(userId, "판매중"));
        model.addAttribute("userPnt", userService.readbyId(userId).getPnt());
        model.addAttribute("principal", principal);
        return "/user/mypage/sellDetail";

    }
}
