package com.ncncn.controller;

import com.ncncn.domain.CriteriaSM;
import com.ncncn.service.GifticonService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Log4j
@RequestMapping("/gifticon")
@AllArgsConstructor
public class GifticonController {

    GifticonService gifticonService;

    @PostMapping("/stus005")
    public String gftDealCmpl(int gftId, CriteriaSM cri, Model model){

        gifticonService.gftDealCmpl(gftId);
        log.info("gft no-" + gftId + " status changed 005");
        log.info("cri teria : " + cri.getAmount() + ",," + cri.getPageNum());
        model.addAttribute("cri",cri);
        return "redirect:/user/mypage/deal";
    }
}
