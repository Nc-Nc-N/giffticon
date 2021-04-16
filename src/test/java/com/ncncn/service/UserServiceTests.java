package com.ncncn.service;

import com.ncncn.domain.UserVO;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/applicationContext.xml")
@Log4j
public class UserServiceTests {

    @Autowired
    UserService userService;

    @Test
    public void testReadById() {

        int userId = 157;

        UserVO user = userService.readbyId(userId);

        log.info("user pnt : " + user.getPnt());
    }

}
