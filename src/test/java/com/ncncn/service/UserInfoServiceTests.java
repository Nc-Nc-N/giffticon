package com.ncncn.service;

import com.ncncn.domain.UserInfoDTO;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.assertEquals;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/applicationContext.xml")
@Log4j

public class UserInfoServiceTests {

    @Autowired
    UserInfoService userInfoService;

    @Test
    public void getMyInfotest(){

        int userId = 166;

        UserInfoDTO user = userInfoService.getMyInfo(userId);

        assertEquals(user.getId(), 166);
        assertEquals(user.getAcc(), null);
        assertEquals(user.getBnkCode(), null);
    }

}
