package com.ncncn.service;

import com.ncncn.domain.CriteriaSM;
import com.ncncn.domain.MyDealsDTO;
import com.ncncn.domain.UserVO;
import com.ncncn.mapper.UserMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.assertNotNull;

@RunWith(SpringJUnit4ClassRunner.class)
@Log4j
@ContextConfiguration("file:src/main/webapp/WEB-INF/applicationContext.xml")
public class DealListServiceTests {

    @Setter(onMethod_ = @Autowired)
    private DealListService service;

    @Setter(onMethod_ = @Autowired)
    private UserCheckService userCheckService;

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
        List<MyDealsDTO> myDealsDTO = service.getGftDetail(gftid, userid);

        log.info("permited user is : " + userid);
    }

    @Test
    public void testGetDealsWithPaging() {

        CriteriaSM cri = new CriteriaSM(3, 3);
        int userId = 55;

        service.getDealsWithPaging(userId, cri);

        log.info("Get Deals With Paging : " + userId + "," + cri.getAmount() + "," + cri.getPageNum());
    }

    @Test
    public void testCountStus004() {

        int userId = 157;

        service.countStus004(userId);
    }

    @Test
    public void testCountStus001N002() {

        int userId = 157;

        String stusName = "판매중";

        service.countStus001N002(userId, stusName);
    }

}
