package com.ncncn.controller;

import com.ncncn.domain.CriteriaCH;
import com.ncncn.domain.PageDTOCH;
import com.ncncn.domain.UserMemoDTO;
import com.ncncn.domain.UserVO;
import com.ncncn.service.UserCheckService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Log4j
@RequestMapping("/admin/user")
@AllArgsConstructor
public class UserCheckController {

    private UserCheckService service;

    @GetMapping("/userlist")
    public String userList(CriteriaCH cri, Model model) {
        log.info("---------log: " + cri);
        model.addAttribute("list", service.getUserList(cri));

        int total = service.getTotal(cri);

        log.info("total: " + total);
        model.addAttribute("pageMaker", new PageDTOCH(cri, total));

        return "/admin/user/userList";
    }

    @GetMapping("/user-detail")
    public String userDetailCheck(int userId, Model model) {
        log.info("userDetailCheck...................");
        model.addAttribute("user", service.getUserDetail(userId));

        return "admin/user/userDetail";
    }

    // user-detail 페이지에서 수정버튼 눌렀을 때 쿼리 실행해서 수정하고 다시 user-detail 페이지로 이동
    @PostMapping("/update-memo")
    public String updateMemo(UserMemoDTO memo) {
        log.info("memo changed..................");

        service.updateMemo(memo);

        return "redirect:admin/user/user-detail?userId=" + memo.getId();
    }

}
