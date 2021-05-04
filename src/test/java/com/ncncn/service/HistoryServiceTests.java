package com.ncncn.service;

import com.ncncn.domain.pagination.AdminConHistCriteria;
import com.ncncn.domain.pagination.AdminDealHistCriteria;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/applicationContext.xml")
@Log4j
public class HistoryServiceTests {

    @Setter(onMethod_ = {@Autowired})
    HistoryService historyService;

    @Test
    public void testGetAdminDealHist() {
        historyService.getAdminDealHist(new AdminDealHistCriteria(2, 10)).forEach(board -> log.info(board));
    }

    @Test
    public void testGetAdminConHist() {
        historyService.getAdminConHist(new AdminConHistCriteria()).forEach(board -> log.info(board));
    }
}
