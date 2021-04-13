package com.ncncn.controller;

import com.ncncn.domain.CriteriaSM;
import com.ncncn.service.GifticonService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@Log4j
@RequestMapping("/gifticon")
@AllArgsConstructor
public class GifticonController {

    GifticonService gifticonService;

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
}
