package com.ncncn.controller;

import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/login")
@Log4j
public class LoginController {

    @GetMapping("/signUp")
    public void signup(String error, String logout, Model model){

        if(error != null){
            log.info("error:" + error);
            model.addAttribute("error", "이메일 또는 비밀번호가 일치하지 않습니다.");
        }

        if(logout != null){
            log.info("logout:" + logout);
            model.addAttribute("logout", "로그아웃 되었습니다.");
        }
    }
}
