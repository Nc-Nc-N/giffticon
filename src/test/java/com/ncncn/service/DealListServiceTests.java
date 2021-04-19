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

import static org.junit.Assert.assertEquals;
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

        assertEquals(myDealsDTO.get(0).getGftId(),80);
        assertEquals(myDealsDTO.get(0).getBrdName(),"스타벅스");
        assertEquals(myDealsDTO.get(0).getStusCode(), "거래확정대기");
    }

    @Test
    public void testGetDealsWithPaging() {


        int userId = 156;

        CriteriaSM cri = new CriteriaSM(1, 3);
        CriteriaSM cri2 = new CriteriaSM(1, 4);

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
