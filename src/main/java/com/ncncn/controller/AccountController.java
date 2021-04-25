package com.ncncn.controller;

import com.ncncn.domain.UserVO;
import com.ncncn.service.SignUpServiceImpl;
import com.ncncn.util.EmailAuthCodeUtils;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/account/*")
@Log4j
public class AccountController {

    private final SignUpServiceImpl signUpServiceImpl;
    private final JavaMailSender javaMailSender;

    public AccountController(SignUpServiceImpl signUpServiceImpl, JavaMailSender javaMailSender) {
        this.signUpServiceImpl = signUpServiceImpl;
        this.javaMailSender = javaMailSender;
    }

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

    @GetMapping("/signUp")
    public String getSignUp() {
        return "/account/signUp";
    }

    @PostMapping(value = "/register", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
    public ResponseEntity<String> register(@RequestBody UserVO user) {
        log.info("UserVO: " + user);

        try {
            int result = signUpServiceImpl.register(user);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }

        return new ResponseEntity<>("success", HttpStatus.OK);
    }

    @GetMapping(value = "/checkExists", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Integer> getUser(@RequestParam("email") String email) {
        int isExists = 0;

        try {
            UserVO userVO = signUpServiceImpl.getByEmail(email);
            if (userVO != null) isExists = 1;
        } catch (Exception e) {
            log.error(e.getMessage());
            return new ResponseEntity<>(isExists, HttpStatus.INTERNAL_SERVER_ERROR);
        }

        return new ResponseEntity<>(isExists, HttpStatus.OK);
    }

    @GetMapping(value = "/emailConfirm", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Map<String, String>> confirmEmail(@RequestParam("email") String email) {
        Map<String, String> map = new HashMap<>();

        String code = EmailAuthCodeUtils.getAuthCode();

        SimpleMailMessage message = new SimpleMailMessage();

        try {
            message.setTo(email);

            message.setSubject("기쁘티콘 회원가입 이메일 인증");
            message.setText("인증 코드: " + code);

            javaMailSender.send(message);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }

        map.put("code", code);

        return new ResponseEntity<>(map, HttpStatus.OK);
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
