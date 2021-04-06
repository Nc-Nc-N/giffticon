package com.ncncn.controller;

import lombok.extern.log4j.Log4j;
import org.apache.ibatis.jdbc.Null;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.security.Principal;

@Controller
@RequestMapping("/login")
@Log4j
public class LoginController {

    @GetMapping("/signIn")
    public void signin(HttpServletRequest request, String error, Model model) {

        log.info("Login Controller...");

        if (error != null) {
            log.info("msg:" + error);
            model.addAttribute("msg", "이메일 또는 비밀번호가 일치하지 않습니다.");
        }

        if (request.getAttribute("logout") != null) {
            log.info("msg logout");
            model.addAttribute("msg", "로그아웃 되었습니다.");
        }
    }

}
