package com.ncncn.service;

import com.ncncn.domain.pagination.UserCheckCriteria;
import com.ncncn.domain.UserDetailCheckVO;
import com.ncncn.domain.UserMemoVO;
import com.ncncn.domain.UserStatusVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.assertEquals;
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

        service.getUserList(new UserCheckCriteria(2, 10)).forEach(user -> log.info(user));
    }

    @Test
    public void testGetUserDetail() {
        int userId=152;
        log.info(service.getUserDetail(userId));
        assertEquals(152, service.getUserDetail(userId).getId());
    }

    @Test
    public void testUpdateMemo() {
        UserMemoVO memo = new UserMemoVO();
        memo.setId(152);
        memo.setMemo("Memo update test123");

        service.updateMemo(memo);
        

        UserDetailCheckVO user = service.getUserDetail(152);
        assertEquals(user.getMemo(), "Memo update test123");
    }

    @Test
    public void testUpdateStatus() {
        UserStatusVO stus = new UserStatusVO();
        stus.setId(152);
        stus.setEnabled(0);

        service.updateStatus(stus);
        assertEquals(0, service.getUserDetail(152).getEnabled());
    }

    @Test
    public void testUpdateStatus2() {
        UserStatusVO stus = new UserStatusVO();
        stus.setId(152);
        stus.setEnabled(1);

        service.updateStatus(stus);
        assertEquals(1, service.getUserDetail(152).getEnabled());
    }
}
