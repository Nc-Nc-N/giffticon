package com.ncncn.controller;

import com.ncncn.domain.pagination.AdminConHistCriteria;
import com.ncncn.domain.pagination.AdminDealHistCriteria;
import com.ncncn.domain.pagination.PageDTO;
import com.ncncn.service.HistoryService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@Log4j
@AllArgsConstructor
public class HistoryController {

    private HistoryService historyService;

    @GetMapping("/admin/deal-history")
    public String adminDealHistory(AdminDealHistCriteria cri, Model model) {

        log.info("list: " + cri);
        model.addAttribute("list", historyService.getAdminDealHist(cri));

        int total = historyService.getTotal(cri);

        log.info("total: " + total);
        model.addAttribute("pageMaker", new PageDTO(cri, total));

        return "/admin/history/deal_history";
    }

    @GetMapping("/admin/con-history")
    public String adminConHistory(AdminConHistCriteria cri, Model model) {

        log.info("list: " + cri);
        model.addAttribute("list", historyService.getAdminConHist(cri));

        int total = historyService.getConTotal(cri);

        log.info("total: " + total);
        model.addAttribute("pageMaker", new PageDTO(cri, total));

        return "/admin/history/con_history";
    }
}
