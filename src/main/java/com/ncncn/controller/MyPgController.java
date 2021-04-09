package com.ncncn.controller;

import com.ncncn.domain.MyDealsDTO;
import com.ncncn.service.DnSListService;
import com.ncncn.service.UserCheckService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
    public void deals(Principal principal, Model model){

        log.info("email: " + principal.getName());

        String email = principal.getName();

        log.info("deals loading..");
        model.addAttribute("dealList", service.getDeals(email));
    }

}
