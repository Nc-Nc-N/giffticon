package com.ncncn.mapper;

import com.ncncn.domain.CriteriaSM;
import com.ncncn.domain.MyDealsDTO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@Log4j
@ContextConfiguration("file:src/main/webapp/WEB-INF/applicationContext.xml")
public class DnSMapperTests {

    @Setter(onMethod_ = @Autowired)
    private DnSListMapper dnsmapper;

//    @Test
//    public void testDealList(){
//
//        String email = "leehj.kk@gmail.com";
//        dnsmapper.getDeals(email).forEach(board -> log.info(board));
//    }

    @Test
    public void testGetGftDetail(){

        int gftId = 85;
        dnsmapper.getGftDetail(gftId);
    }

    @Test
    public void testPaging(){
        int amount = 2;
        int pageNum = 2;
        String email = "planner263@gmail.com";
        List<MyDealsDTO> list = dnsmapper.getDealsWithPaging(email, amount, pageNum);
        list.forEach(board -> log.info(board));
    }
}
