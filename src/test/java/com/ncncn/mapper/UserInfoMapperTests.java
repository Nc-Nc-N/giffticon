package com.ncncn.mapper;

import com.ncncn.domain.UserInfoDTO;
import lombok.Setter;
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
public class UserInfoMapperTests {

    @Setter(onMethod_ = @Autowired)
    UserInfoMapper mapper;

    @Test
    public void getMyInfoTest(){

        int userId = 157;

        UserInfoDTO user = mapper.getMyInfo(userId);

        log.info(user.toString());

        assertEquals(user.getHolder(),null);
    }
}
