package com.ncncn.mapper;

import com.ncncn.domain.UserDetailCheckVO;
import com.ncncn.domain.UserMemoVO;
import com.ncncn.domain.UserVO;
import com.ncncn.domain.pagination.UserCheckCriteria;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;

import org.springframework.beans.factory.annotation.Autowired;
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

        assertEquals(user.getEmail(),"leehj.kk@gmail.com");
        assertEquals(user.getName(),"hj");
        assertEquals(user.getMemo(),null);
        assertEquals(user.getEnabled(),1);
    }

    @Test
    public void readByEmail() {

        String userEmail = "planner263@gmail.com";

        UserVO user = userMapper.readByEmail(userEmail);

        log.info("userVO : " + user);

        assertEquals(user.getId(), 156);
        assertEquals(user.getMemo(), null);
        assertEquals(user.getEnabled(), 1);
        assertEquals(user.getPnt(), 0);
    }

    // 295page
    @Test
    public void tesetPaging() {

        UserCheckCriteria cri = new UserCheckCriteria();

        List<UserVO> list = userMapper.getListWithPaging(cri);

        list.forEach(user -> log.info(user));
    }

    //336page
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
        UserMemoVO updateMemo = new UserMemoVO();
        updateMemo.setId(userId);
        updateMemo.setMemo(memo);

        userMapper.updateMemo(updateMemo);

        UserDetailCheckVO user = userMapper.getUserDetail(152);

        assertEquals(user.getMemo(), "Memo Update Test");

    }
}
