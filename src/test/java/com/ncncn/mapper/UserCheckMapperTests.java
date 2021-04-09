package com.ncncn.mapper;


import com.ncncn.domain.CriteriaCH;
import com.ncncn.domain.UserDetailCheckDTO;
import com.ncncn.domain.UserVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

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

        CriteriaCH cri = new CriteriaCH();

        List<UserVO> list = mapper.getListWithPaging(cri);

        list.forEach(user -> log.info(user));
    }

    //336page
    @Test
    public void testSearch() {

        CriteriaCH cri = new CriteriaCH();
        cri.setKeyword("3333");
        cri.setType("T");

        List<UserVO> list = mapper.getListWithPaging(cri);

        list.forEach(user -> log.info(user));
    }

    @Test
    public void testGetUser(){

        int userId=152;
        UserDetailCheckDTO user = mapper.getUserDetail(userId);
        log.info(user);

    }

    @Test
    public void testUpdateMemo() {

        int userId=152;
        String memo="스파이더맨55";


    }



}
