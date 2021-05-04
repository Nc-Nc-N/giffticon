package com.ncncn.service;

import com.ncncn.domain.pagination.MyPageCriteria;
import com.ncncn.domain.MySellVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.assertEquals;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/applicationContext.xml")
@Log4j
public class SellListServiceTests {

    @Setter(onMethod_ = @Autowired)
    SellListService sellListService;

    @Test
    public void testCountSellList(){

        int userId = 156;

        MyPageCriteria cri = new MyPageCriteria(1,3);

        int countList = sellListService.countSellList(userId, cri);

        assertEquals(countList, 12);
    }

    @Test
    public void testGetSellsWithPaging(){

        int userId = 156;
        MyPageCriteria cri = new MyPageCriteria(2,3);

        List<MySellVO> sellList = sellListService.getSellsWithPaging(userId, cri);

        assertEquals(sellList.size(), 3);
    }

    @Test
    public void testGetSellDetail(){

        int userId = 5;
        int gftId = 60;

        MySellVO sellDetail = sellListService.getSellDetail(gftId, userId);

        assertEquals(sellDetail.getUserId(), 5);
        assertEquals(sellDetail.getDcPrc(), 13000);
        assertEquals(sellDetail.getPrdCode(), "010128");
        assertEquals(sellDetail.getIsAutoPrc(), '0');
    }

    @Test
    public void testCountStus001N002() {

        int userId = 156;

        String stusName = "판매대기";

        int count001 = sellListService.countStus001N002(userId, stusName);

        assertEquals(count001, 6);
    }
}
