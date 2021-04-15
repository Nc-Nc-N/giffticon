package com.ncncn.service;

import com.ncncn.domain.CriteriaSM;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/applicationContext.xml")
@Log4j
public class SellListServiceTests {

    @Setter(onMethod_ = @Autowired)
    SellListService sellListService;

    @Test
    public void testCountSellList(){

        int userId = 156;
        CriteriaSM cri = new CriteriaSM(2,3);

        sellListService.countSellList(userId, cri);
    }

    @Test
    public void testGetSellsWithPaging(){

        int userId = 156;
        CriteriaSM cri = new CriteriaSM(2,3);

        sellListService.getSellsWithPaging(userId, cri);
    }

    @Test
    public void testGetSellDetail(){

        int userId = 157;
        int gftId = 59;

        sellListService.getSellDetail(gftId, userId);
    }
}
