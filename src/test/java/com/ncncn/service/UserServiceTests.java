package com.ncncn.service;

import com.ncncn.domain.UserInfoDTO;

import com.ncncn.domain.UserDetailCheckVO;
import com.ncncn.domain.UserMemoVO;
import com.ncncn.domain.UserStatusVO;
import com.ncncn.domain.UserVO;
import com.ncncn.domain.pagination.UserCheckCriteria;
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
public class UserServiceTests {

    @Autowired
    UserService userService;

    @Test
    public void testReadById() {

        int userId = 156;

        UserVO user = userService.readbyId(userId);

        log.info("user pnt : " + user.getPnt());

        assertEquals(user.getEmail(),"planner263@gmail.com");
        assertEquals(user.getEnabled(),1);
        assertEquals(user.getRoleCode(),"002");
    }

    @Test
    public void testExists() {
        log.info(userService);
        assertNotNull(userService);
    }

    @Test
    public void testGetUserList() {

        userService.getUserList(new UserCheckCriteria(2, 10)).forEach(user -> log.info(user));
    }

    @Test
    public void testGetUserListQuit() {

        userService.getUserListQuit(new UserCheckCriteria(1, 10)).forEach(user -> log.info(user));
    }

    @Test
    public void testGetUserDetail() {
        int userId=152;
        log.info(userService.getUserDetail(userId));
        assertEquals(152, userService.getUserDetail(userId).getId());
    }

    @Test
    public void testUpdateMemo() {
        UserMemoVO memo = new UserMemoVO();
        memo.setId(152);
        memo.setMemo("Memo update test123");

        userService.updateMemo(memo);


        UserDetailCheckVO user = userService.getUserDetail(152);
        assertEquals(user.getMemo(), "Memo update test123");
    }

    @Test
    public void testUpdateStatus() {
        UserStatusVO stus = new UserStatusVO();
        stus.setId(152);
        stus.setEnabled(0);

        userService.updateStatus(stus);
        assertEquals(0, userService.getUserDetail(152).getEnabled());
    }

    @Test
    public void testUpdateStatus2() {
        UserStatusVO stus = new UserStatusVO();
        stus.setId(152);
        stus.setEnabled(1);

        userService.updateStatus(stus);
        assertEquals(1, userService.getUserDetail(152).getEnabled());
    }

    @Test
    public void getMyInfotest() {

        int userId = 156;

        UserInfoDTO user = userService.getMyInfo(userId);

        assertEquals(user.getId(), 156);
    }

    @Test
    public void updatePwdTest(){

        int userId = 5;
        String email = "test1@test.com";
        String pwd = "343412";

        int isUpdated = userService.updatePwd(pwd,email,userId);
        if(isUpdated == 1 ){

            String newPwd = userService.readbyId(5).getPwd();

            assertEquals(pwd, newPwd);
        }else{
            assertEquals(isUpdated,0);
        }
    }

}
