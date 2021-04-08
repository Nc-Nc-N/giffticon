package com.ncncn.service;

import com.ncncn.domain.CriteriaCH;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.assertNotNull;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/applicationContext.xml")
@Log4j
public class UserCheckServiceTests {

    @Setter(onMethod_ = {@Autowired})
    private UserCheckService service;

    @Test
    public void testExists() {
        log.info(service);
        assertNotNull(service);
    }

    @Test
    public void testGetUserList() {

        service.getUserList(new CriteriaCH(2, 10)).forEach(user -> log.info(user));
    }
}
