package com.ncncn.service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.assertNotNull;

@RunWith(SpringJUnit4ClassRunner.class)
@Log4j
@ContextConfiguration("file:src/main/webapp/WEB-INF/applicationContext.xml")
public class DnSListServiceTests {

    @Setter(onMethod_ = @Autowired)
    private DnSListService service;

    @Test
    public void serviceTest(){

        log.info("service test...");

        assertNotNull(service);
    }

    @Test
    public void testGetDeals(){
        String email = "leehj.kk@gmail.com";

        service.getDeals(email);
        log.info("검색하신 " + email + " 의 주문 내역 입니다.");
    }

}
