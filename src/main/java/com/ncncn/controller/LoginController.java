package com.ncncn.controller;

import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/account")
@Log4j
public class LoginController {

    @GetMapping("/signIn")
    public void signIn(HttpServletRequest request, String error, Model model) {

        log.info("Login Controller...");

        model = cookieChecker(request, model);

        if (error != null) {
            log.info("msg:" + error);
            model.addAttribute("msg", "이메일 또는 비밀번호가 일치하지 않습니다.");
        }

        if (request.getSession().getAttribute("logout") != null) {
            model.addAttribute("msg", "로그아웃되었습니다.");
            request.getSession().removeAttribute("logout");
        }

        request.getSession().setAttribute("referer", request.getHeader("referer"));

    }

    public Model cookieChecker(HttpServletRequest request, Model model) {

        Cookie[] cookies = request.getCookies();

        if (cookies != null) {
            for (int i = 0; i < cookies.length; i++) {
                if (cookies[i].getName().equals("remEmail")) {
                    model.addAttribute("email", cookies[i].getValue());
                    model.addAttribute("isRemember", "checked");
                }
            }
        }
        return model;
    }
}
