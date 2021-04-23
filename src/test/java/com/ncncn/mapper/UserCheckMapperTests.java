package com.ncncn.mapper;


import com.ncncn.domain.pagination.UserCheckCriteria;
import com.ncncn.domain.UserDetailCheckVO;
import com.ncncn.domain.UserMemoVO;
import com.ncncn.domain.UserVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import static org.junit.Assert.*;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.assertEquals;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/applicationContext.xml")
@Log4j
public class UserCheckMapperTests {

    @Setter(onMethod_ = @Autowired)
    private UserCheckMapper mapper;

    @Test
    public void testGetUserList() {
        mapper.getUserList().forEach(user -> log.info(user));
    }

    // 295page
    @Test
    public void tesetPaging() {

        UserCheckCriteria cri = new UserCheckCriteria();

        List<UserVO> list = mapper.getListWithPaging(cri);

        list.forEach(user -> log.info(user));
    }

    //336page
    @Test
    public void testSearch() {

        UserCheckCriteria cri = new UserCheckCriteria();
        cri.setKeyword("3333");
        cri.setType("T");

        List<UserVO> list = mapper.getListWithPaging(cri);

        list.forEach(user -> log.info(user));

        assertTrue(list.get(0).getTelNo().contains("3333"));

    }

    @Test
    public void testGetUser(){

        int userId=152;
        UserDetailCheckVO user = mapper.getUserDetail(userId);
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

        mapper.updateMemo(updateMemo);

        UserDetailCheckVO user = mapper.getUserDetail(152);

        assertEquals(user.getMemo(), "Memo Update Test");

    }



}
