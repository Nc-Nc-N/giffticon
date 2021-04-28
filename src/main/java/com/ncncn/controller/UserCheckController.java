package com.ncncn.controller;


import com.ncncn.domain.*;

import com.ncncn.domain.pagination.UserCheckCriteria;
import com.ncncn.domain.pagination.PageDTO;
import com.ncncn.service.UserService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@Log4j
@RequestMapping("/admin/user")
@AllArgsConstructor
public class UserCheckController {

    private UserService userService;

    @GetMapping("/userlist")
    public String userList(UserCheckCriteria cri, Model model) {
        log.info("---------log: " + cri);
        model.addAttribute("list", userService.getUserList(cri));

        int total = userService.getTotal(cri);

        log.info("total: " + total);
        model.addAttribute("pageMaker", new PageDTO(cri, total));

        return "/admin/user/userList";
    }

    @GetMapping("/userlist-quit")
    public String userListQuit(UserCheckCriteria cri, Model model) {
        log.info("---------log: " + cri);
        model.addAttribute("quitlist", userService.getUserListQuit(cri));

        int total = userService.getTotalQuit(cri);

        log.info("total: " + total);
        model.addAttribute("pageMaker", new PageDTO(cri, total));

        return "/admin/user/quitUserList";
    }

    @GetMapping("/user-detail")
    public String userDetailCheck(int userId, Model model) {
        log.info("userDetailCheck...................");
        model.addAttribute("user", userService.getUserDetail(userId));

        return "admin/user/userDetail";
    }

    // user-detail 페이지에서 수정버튼 눌렀을 때 쿼리 실행해서 수정하고 다시 user-detail 페이지로 이동
    @PostMapping("/update-memo")
    public String updateMemo(HttpServletRequest request) {
        log.info("memo changed..................");
        UserMemoVO updateMemo = new UserMemoVO();

        // request.getParameter가 반환하는 문자열 값을 int로 변환해줌
        updateMemo.setId(Integer.parseInt(request.getParameter("id")));
        updateMemo.setMemo(request.getParameter("memo"));

        userService.updateMemo(updateMemo);

        return "redirect:/admin/user/user-detail?userId=" + updateMemo.getId();
    }

    // user-detail 페이지에서 회원상태 변경시 쿼리 실행해서 수정하고 다시 user-detail 페이지로 이동
    @PostMapping("/update-status")
    public String updateStatus(HttpServletRequest request) {
        log.info("status changed................");
        UserStatusVO updateStat = new UserStatusVO();

        updateStat.setId(Integer.parseInt(request.getParameter("id")));

        String status = request.getParameter("statusTxt");
        if(status.equals("정상")) {
            updateStat.setEnabled(1);
        } else if(status.equals("탈퇴")) {
            updateStat.setEnabled(0);
        }

        userService.updateStatus(updateStat);

        return "redirect:/admin/user/user-detail?userId=" + updateStat.getId();
    }
}
