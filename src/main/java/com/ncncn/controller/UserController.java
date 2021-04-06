package com.ncncn.controller;

import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/user")
@Log4j
public class UserController {

    @GetMapping("/home")
    public void userMain(){
        log.info("user home");
    }

    @GetMapping("/mypage/mypageDeals")
    public void userMypage(){
        log.info("user mypage");
    }
}
