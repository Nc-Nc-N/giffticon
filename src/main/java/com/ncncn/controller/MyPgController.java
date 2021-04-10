package com.ncncn.controller;

import com.ncncn.domain.CriteriaSM;
import com.ncncn.domain.MyDealsDTO;
import com.ncncn.domain.UserVO;
import com.ncncn.service.DnSListService;
import com.ncncn.service.UserCheckService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.Principal;
import java.util.Arrays;
import java.util.List;

@Controller
@Log4j
@RequestMapping("/user/mypage")
@AllArgsConstructor
public class MyPgController {

    private DnSListService service;
    private UserCheckService userCheckService;

    @GetMapping("/deal")
    public void deals(Principal principal, CriteriaSM cri, Model model){

        log.info("email: " + principal.getName());

        String email = principal.getName();

        log.info("deals loading..");

        model.addAttribute("dealList", service.getDealsWithPaging(email, cri.getAmount(), cri.getPageNum()));
    }

    @PostMapping("/dealDetail")
    public void dealDetail(Principal principal, int gftId, Model model)
                            throws IOException {

        log.info("Get Detail of gftId: " + gftId);
        log.info("user Email: " + principal.getName());

        MyDealsDTO gftInfo =  service.getGftDetail(gftId).get(0);
        UserVO user = userCheckService.specUserOnly(gftInfo.getCsId());


        log.info("gftInfo: " + gftInfo.toString());
        model.addAttribute("gftInfo",gftInfo);
    }


}
