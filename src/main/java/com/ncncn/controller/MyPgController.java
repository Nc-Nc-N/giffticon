package com.ncncn.controller;

import com.ncncn.service.DnSListService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;

@Controller
@Log4j
@RequestMapping("/user/mypage")
@AllArgsConstructor
public class MyPgController {

    private DnSListService service;

    @PostMapping("/deal")
    public void deals(Principal principal, Model model){

        log.info("email: " + principal.getName());

        String email = principal.getName();

//        log.info("deals loading..");
        model.addAttribute("dealList", service.getDeals(email));
    }

    @GetMapping("/dealDetail")
    public void dealDetail(@RequestParam("giftNo") int giftno, Model model){
        log.info("/")
    }
}
