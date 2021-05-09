package com.ncncn.service;

import com.ncncn.domain.pagination.MyPageCriteria;
import com.ncncn.domain.MyDealsVO;
import com.ncncn.mapper.UserMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

@RunWith(SpringJUnit4ClassRunner.class)
@Log4j
@ContextConfiguration("file:src/main/webapp/WEB-INF/applicationContext.xml")
public class DealListServiceTests {

    @Setter(onMethod_ = @Autowired)
    private DealListService service;

    @Setter(onMethod_ = @Autowired)
    private UserService userService;

    @Setter(onMethod_ = @Autowired)
    private UserMapper userMapper;

    @Test
    public void serviceTest() {

        log.info("service test...");

        assertNotNull(service);
    }

    @Test
    public void testGetGftDetail() {
        int gftid = 80;
        int userid = 157;
        MyDealsVO myDealsVO = service.getGftDetail(gftid, userid);

        log.info("permited user is : " + userid);

        assertEquals(myDealsVO.getGftId(),80);
        assertEquals(myDealsVO.getBrdName(),"스타벅스");
        assertEquals(myDealsVO.getStusCode(), "거래확정대기");
    }

    @Test
    public void testGetDealsWithPaging() {


        int userId = 156;

        MyPageCriteria cri = new MyPageCriteria(1, 3);
        MyPageCriteria cri2 = new MyPageCriteria(1, 4);

        int sizeofList = service.getDealsWithPaging(userId, cri).size();
        int sizeofList2 = service.getDealsWithPaging(userId, cri2).size();

        assertEquals(sizeofList,3);
        assertEquals(sizeofList2,4);

    }

    @Test
    public void testCountStus004() {

        int userId = 157;
        int userId2 = 156;

        int count004 = service.countStus004(userId);
        int count004_2 = service.countStus004(userId2);

        assertEquals(count004, 1);
        assertEquals(count004_2, 5);
    }

}
