package com.ncncn.service;

import com.ncncn.domain.CriteriaCH;
import com.ncncn.domain.UserMemoDTO;
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

    @Test
    public void testGetUser() {
        int userId=152;
        service.getUserDetail(userId);
    }

    @Test
    public void testUpdateMemo() {
        UserMemoDTO memo = new UserMemoDTO();
        memo.setId(152);
        memo.setMemo("Memo update test");

        service.updateMemo(memo);
    }
}
