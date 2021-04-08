package com.ncncn.controller;

import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.security.Principal;

@Controller
@Log4j
@RequestMapping("/user/mypage")
public class MyPgController {

    @GetMapping("/deal")
    public void deals(Principal principal){
        log.info(principal.getName());

        log.info("deals loading..");
    }
}
