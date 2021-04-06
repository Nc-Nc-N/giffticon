package com.ncncn.controller;

import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
@Log4j
public class AdminContoller {

    @GetMapping("/admin_main")
    public void adminMain(){
        log.info("admin Main");
    }
}
