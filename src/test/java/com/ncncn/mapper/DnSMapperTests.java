package com.ncncn.mapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@Log4j
@ContextConfiguration("file:src/main/webapp/WEB-INF/applicationContext.xml")
public class DnSMapperTests {

    @Setter(onMethod_ = @Autowired)
    private DnSListMapper dnsmapper;

    @Test
    public void testDealList(){

        String email = "planner263@gmail.com";
        dnsmapper.getDeals(email).forEach(board -> log.info(board));
    }
}
