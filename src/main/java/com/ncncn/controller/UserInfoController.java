package com.ncncn.controller;

import com.ncncn.domain.UserInfoDTO;
import com.ncncn.service.DealListService;
import com.ncncn.service.SellListService;
import com.ncncn.service.UserService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@Log4j
@RequestMapping("/user/mypage")
@AllArgsConstructor
public class UserInfoController {

    UserService userService;

    DealListService dealListService;

    SellListService sellListService;

    @GetMapping("/userInfo")
    public void userInfo(HttpServletRequest request, Model model) {

        int userId = (int) request.getSession().getAttribute("userId");

        UserInfoDTO user = userService.getMyInfo(userId);

        model.addAttribute("countStus004", dealListService.countStus004(userId));
        model.addAttribute("countStus001", sellListService.countStus001N002(userId, "판매대기"));
        model.addAttribute("countStus002", sellListService.countStus001N002(userId, "판매중"));
        model.addAttribute("userPnt", userService.readbyId(userId).getPnt());
        model.addAttribute("user", user);

    }
}
