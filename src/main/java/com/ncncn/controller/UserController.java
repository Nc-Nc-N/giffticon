package com.ncncn.controller;

import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/user")
@Log4j
public class UserController {

    @GetMapping("/main")
    public void userMain(){
        log.info("user main");
    }

    @GetMapping("/mypage/mypage")
    public void userMypage(){
        log.info("user mypage");
    }
}
