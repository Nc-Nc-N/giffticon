package com.ncncn.controller;

import com.ncncn.domain.CriteriaCH;
import com.ncncn.domain.PageDTOCH;
import com.ncncn.domain.UserVO;
import com.ncncn.service.UserCheckService;
import com.ncncn.service.UserService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@Log4j
@RequestMapping("/admin/user")
@AllArgsConstructor
public class UserCheckController {

    private UserCheckService service;
    private UserService userService;

    @GetMapping("/userlist")
    public String userList(CriteriaCH cri, Model model) {
        log.info("---------log: " + cri);
        model.addAttribute("list", service.getUserList(cri));

        int total = service.getTotal(cri);

        log.info("total: " + total);
        model.addAttribute("pageMaker", new PageDTOCH(cri, total));

        return "/admin/user/userList";

    }
}
