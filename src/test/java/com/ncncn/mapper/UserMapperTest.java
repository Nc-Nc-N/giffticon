package com.ncncn.mapper;

import com.ncncn.domain.*;
import com.ncncn.domain.pagination.UserCheckCriteria;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/applicationContext.xml")
@Log4j

public class UserMapperTest {

    @Setter(onMethod_ = @Autowired)
    private UserMapper userMapper;

    @Setter(onMethod_ = @Autowired)
    private SoclInfoMapper soclInfoMapper;

    @Test
    public void registerAndFindUserByEmailTest() {
        UserVO user = new UserVO();
        user.setEmail("registerTest@test.com");
        user.setName("test");
        user.setPwd("test1234");
        user.setTelNo("010-1234-5678");
        user.setEmlAuthTkn("AAAAAAAA");

        int result = userMapper.insertUser(user);

        UserVO findUser = userMapper.readUserByEmail(user.getEmail());

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

        userMapper.insertUser(user);

        int result = userMapper.deleteByEmail(user.getEmail());

        assertEquals(1, result);
    }

    @Test
    public void readById() {
        int userId = 157;

        UserVO user = userMapper.readById(userId);
        log.info("pnt : " + user.getPnt());

        assertEquals(user.getEmail(),"leehj.kk@gmail.com");
        assertEquals(user.getName(),"hj");
        assertEquals(user.getMemo(),null);
        assertEquals(user.getEnabled(),1);
    }

    @Test
    public void readByEmail() {

        String userEmail = "planner263@gmail.com";

        UserVO user = userMapper.readUserByEmail(userEmail);

        log.info("userVO : " + user);

        assertEquals(user.getId(), 156);
        assertEquals(user.getMemo(), null);
        assertEquals(user.getEnabled(), 1);
        assertEquals(user.getPnt(), 0);
    }

    @Test
    public void testPaging() {

        UserCheckCriteria cri = new UserCheckCriteria();

        List<UserVO> list = userMapper.getListWithPaging(cri);

        list.forEach(user -> log.info(user));
    }

    @Test
    public void testPagingQuit() {

        UserCheckCriteria cri = new UserCheckCriteria();

        List<UserVO> list = userMapper.getListWithPagingQuit(cri);

        list.forEach(user -> log.info(user));
    }

    @Test
    public void testSearch() {

        UserCheckCriteria cri = new UserCheckCriteria();
        cri.setKeyword("3333");
        cri.setType("T");

        List<UserVO> list = userMapper.getListWithPaging(cri);

        list.forEach(user -> log.info(user));

        assertTrue(list.get(0).getTelNo().contains("3333"));

    }

    @Test
    public void testSearchQuit() {

        UserCheckCriteria cri = new UserCheckCriteria();
        cri.setKeyword("1111");
        cri.setType("T");

        List<UserVO> list = userMapper.getListWithPagingQuit(cri);

        list.forEach(user -> log.info(user));

        assertTrue(list.get(0).getTelNo().contains("1111"));

    }

    @Test
    public void testGetUser(){

        int userId=152;
        UserDetailCheckVO user = userMapper.getUserDetail(userId);
        log.info(user);
        assertEquals(152, user.getId());
        assertNotEquals(111, user.getId());

    }

    @Test
    public void testUpdateMemo() {

        int userId=152;
        String memo="Memo Update Test";
        UserVO updateMemo = new UserVO();
        updateMemo.setId(userId);
        updateMemo.setMemo(memo);

        userMapper.updateMemo(updateMemo);

        UserDetailCheckVO user = userMapper.getUserDetail(152);

        assertEquals(user.getMemo(), "Memo Update Test");

    }

    @Test
    public void getMyInfoTest() {

        int userId = 157;

        UserInfoDTO user = userMapper.getMyInfo(userId);

        log.info(user.toString());

        assertEquals(user.getHolder(), null);
    }

    @Test
    public void updatePwdTest(){

        int userId = 5;
        String email = "test1@test.com";
        String pwd = "password@@@";

        int result = userMapper.updatePwd(pwd,email,userId);

        assertEquals(result, 1);

        String pwdconfirm = userMapper.readById(5).getPwd();

        assertEquals(pwd, pwdconfirm);
    }

    @Test
    public void updatePwdTest2(){
        int userId = 225;
        String email = "planner26@nate.com";
        String pwd = "001123qwe123";
        BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();

        String encodedPwd = bCryptPasswordEncoder.encode(pwd);
        userMapper.updatePwd(encodedPwd,"planner26@nate.com",225);
    }

    @Test
    public void getSocialInfoTest(){

        int userId = 225;
        SoclInfoForSessionDTO soclInfoForSessionDTO = soclInfoMapper.getSocialInfo(userId);
    }
}
