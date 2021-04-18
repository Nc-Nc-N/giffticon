package com.ncncn.mapper;

import com.ncncn.domain.UserInfoDTO;
import com.ncncn.domain.UserVO;
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

public class UserMapperTest {

    @Setter(onMethod_ = @Autowired)
    private UserMapper userMapper;

    @Test
    public void registerAndFindUserByEmailTest() {
        UserVO user = new UserVO();
        user.setEmail("registerTest@test.com");
        user.setName("test");
        user.setPwd("test1234");
        user.setTelNo("010-1234-5678");
        user.setEmlAuthTkn("AAAAAAAA");

        int result = userMapper.insert(user);

        UserVO findUser = userMapper.readByEmail(user.getEmail());

        assertEquals(1, result);
        assertEquals(user.getEmail(), findUser.getEmail());
        assertEquals(user.getPwd(), findUser.getPwd());
        assertEquals(user.getName(), findUser.getName());

        userMapper.deleteByEmail(user.getEmail());
    }

    @Test
    public void deleteByEmailTest() {
        UserVO user = new UserVO();
        user.setEmail("deleteTest@test.com");
        user.setName("test");
        user.setPwd("test1234");
        user.setTelNo("010-1234-5678");
        user.setEmlAuthTkn("AAAAAAAA");

        userMapper.insert(user);

        int result = userMapper.deleteByEmail(user.getEmail());

        assertEquals(1, result);
    }

    @Test
    public void readById() {
        int userId = 157;

        UserVO user = userMapper.readById(userId);
        log.info("pnt : " + user.getPnt());
    }

    @Test
    public void readByEmail() {

        String userEmail = "planner263@gmail.com";

        UserVO user = userMapper.readByEmail(userEmail);

        log.info("userVO : " + user);
    }

    @Test
    public void getMyInfoTest(){

        int userId = 157;

        UserInfoDTO user = userMapper.getMyInfo(userId);

        log.info(user.toString());

        assertEquals(user.getHolder(),null);
    }
}
