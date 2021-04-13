package com.ncncn.controller;

import com.ncncn.domain.CriteriaSM;
import com.ncncn.domain.MyDealsDTO;
import com.ncncn.domain.PageDTOSM;
import com.ncncn.domain.UserVO;
import com.ncncn.service.DnSListService;
import com.ncncn.service.UserCheckService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.IOException;
import java.security.Principal;

@Controller
@Log4j
@RequestMapping("/user/mypage")
@AllArgsConstructor
public class MyPgController {

    private DnSListService service;
    private UserCheckService userCheckService;

    @GetMapping("/deal")
    public void deals(Principal principal, CriteriaSM cri, Model model) {

        log.info("email: " + principal.getName());

        String email = principal.getName();
        int total = service.countDealList(email, cri);
        log.info("service done at controller");
        log.info("keyword: " + cri.getKeyword());
        log.info("type : " + cri.getType());
        log.info("dateFrom : " + cri.getDateFrom());
                log.info("dateTo : "  + cri.getDateTo());
        model.addAttribute("dealList", service.getDealsWithPaging(email, cri));
        model.addAttribute("pageMaker", new PageDTOSM(cri, total));

        log.info("deals loading....");
    }

    @PostMapping("/dealDetail")
    public void dealDetail(Principal principal, int gftId, Model model,
                           @ModelAttribute("cri") CriteriaSM cri)
                            throws IOException {

        log.info("Get Detail of gftId: " + gftId);
        log.info("user Email: " + principal.getName());

        MyDealsDTO gftInfo = service.getGftDetail(gftId).get(0);
        UserVO user = userCheckService.specUserOnly(gftInfo.getCsId());


        log.info("gftInfo: " + gftInfo.toString());
        model.addAttribute("gftInfo", gftInfo);
    }


}
