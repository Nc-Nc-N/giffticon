package com.ncncn.controller;

import com.ncncn.domain.CriteriaSM;
import com.ncncn.domain.GifticonVO;
import com.ncncn.domain.PrcUpdateDTO;
import com.ncncn.domain.UserVO;
import com.ncncn.service.GifticonService;
import com.ncncn.service.UserService;
import com.ncncn.util.UserAuthCheckUtils;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@Controller
@Log4j
@RequestMapping("/gifticon")
@AllArgsConstructor
public class GifticonController {

    GifticonService gifticonService;
    UserService userService;




    @GetMapping("/stus005")
    public String gftDealCmpl(HttpServletRequest request, int gftId, CriteriaSM cri, Model model) {

        gifticonService.gftDealCmpl(gftId);
        log.info("gft no-" + gftId + " status changed 005");
        log.info("cri teria : " + cri.getAmount() + ",," + cri.getPageNum());
        model.addAttribute("cri", cri);

        if (request.getHeader("referer").contains("/dealDetail")) {
            log.info("referer: " + request.getHeader("referer"));
            model.addAttribute("gftId", gftId);
            return "redirect:/user/mypage/dealDetail";
        }
        return "redirect:/user/mypage/deal";
    }

    @GetMapping("/delGft")
    public String deleteGifticon(HttpServletRequest request, int gftId, CriteriaSM cri, Model model){

        log.info("gifticon delete Controller....");
        model.addAttribute("cri",cri);
        log.info("gtfId: " + gftId);
        gifticonService.deleteGifticon(gftId);


        return "redirect:/user/mypage/sells";
    }

    @RequestMapping(method = {RequestMethod.POST},
                    value = "/updateGft",
                    consumes = "application/json",
                    produces = {MediaType.TEXT_PLAIN_VALUE})
    public ResponseEntity<String> updateGifticon(@RequestBody PrcUpdateDTO prcUpdate, HttpServletRequest request){

        log.info("prcUpdate: " + prcUpdate.getEmail().getClass());
        log.info("prcUpdate: " + prcUpdate.getPassword().getClass());
        log.info("prcUpdate: " + prcUpdate.getIsAutoPrc());
        log.info("prcUpdate: " + prcUpdate.getDcPrc());
        log.info("prcUpdate: " + prcUpdate.getGftId());



        int userId = (int)request.getSession().getAttribute("userId");
        UserVO user = userService.readbyId(userId);

        log.info("user : " + user);
        log.info("ajax received........");
        if(UserAuthCheckUtils.userAuthCheck(prcUpdate.getEmail(), prcUpdate.getPassword(), user)){
            log.info("기프티콘 가격 수정....비밀번호 일치");
            return  gifticonService.updateGftPrc(prcUpdate.getGftId(),prcUpdate.getIsAutoPrc(), prcUpdate.getDcPrc())
                    == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
                    : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);

        }else{
            log.info("기프티콘 가격 수정....비밀번호가 일치하지 않습니다.");
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
