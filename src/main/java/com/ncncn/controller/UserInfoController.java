package com.ncncn.controller;

import com.ncncn.domain.PrcUpdateDTO;
import com.ncncn.domain.UserInfoDTO;
import com.ncncn.domain.UserVO;
import com.ncncn.service.DealListService;
import com.ncncn.service.SellListService;
import com.ncncn.service.UserService;
import com.ncncn.util.UserAuthCheckUtils;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

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

    @RequestMapping(value = "/checkPassword",
                method = RequestMethod.POST,
    consumes = "application/json")
    public ResponseEntity<String> checkPwdUserUpdate(@RequestBody UserVO checkuser,
                                                     HttpServletRequest request) {
        log.info("pwd confirm received : " + checkuser.getEmail() + "," + checkuser.getPwd());
        int userId = (int) request.getSession().getAttribute("userId");

        UserVO user = userService.readbyId(userId);

        if(UserAuthCheckUtils.userAuthCheck(checkuser.getEmail(), checkuser.getPwd(), user)){
            return new ResponseEntity<>(HttpStatus.OK);
        }else{
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
