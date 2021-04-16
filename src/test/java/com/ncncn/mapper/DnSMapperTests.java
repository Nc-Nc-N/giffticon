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
    private DealListMapper dealListMapper;

    @Setter(onMethod_ = @Autowired)
    private SellListMapper sellListMapper;

    @Test
    public void testCountDealList(){

        int userId = 41;
        CriteriaSM cri = new CriteriaSM(1,4);
        dealListMapper.countDealList(userId, cri.getDateFrom(), cri.getDateTo(),
                 cri.getKeyword(), cri.getType(), cri.getTypeArr());
    }

    @Test
    public void testGetGftDetail() {

        int gftId = 80;
        int userId = 157;

        dealListMapper.getGftDetail(gftId, userId);
    }

    @Test
    public void testPaging() {
        CriteriaSM cri = new CriteriaSM();
//        cri.setDateFrom("2020-10-22");
//        cri.setDateTo("2021-03-22");
        cri.setPageNum(1);
        cri.setAmount(3);
//        cri.setKeyword("");
//        cri.setType("");
        String[] typeArr = cri.getTypeArr();
        int userId = 33;
        List<MyDealsDTO> list = dealListMapper.getDealsWithPaging(userId, cri.getDateFrom(), cri.getDateTo(),
                cri.getAmount(), cri.getPageNum(), cri.getKeyword(), cri.getType(), typeArr);

        list.forEach(board -> log.info(board));
    }

    @Test
    public void testGetCount004() {

        int userId = 157;

        dealListMapper.countStus004(userId);
    }

    @Test
    public void testCountStus001N002() {

        int userId = 5;

        sellListMapper.countStus001N002(userId, "판매중");
    }

    @Test
    public void testGetSellListWithPaging(){

        int userId = 156;
        CriteriaSM cri = new CriteriaSM(1,4);
        sellListMapper.getSellsWithPaging(userId, cri.getDateFrom(), cri.getDateTo(),
                cri.getAmount(), cri.getPageNum(), cri.getKeyword(), cri.getType(), cri.getTypeArr());
    }

    @Test
    public void testCountSellList(){

        int userId = 155;
        CriteriaSM cri = new CriteriaSM(1,4);
        sellListMapper.countSellList(userId, cri.getDateFrom(), cri.getDateTo(),
                 cri.getKeyword(), cri.getType(), cri.getTypeArr());
    }

    @Test
    public void testGetSellDetail(){

        int userId = 157;
        int gftId =  66;

        sellListMapper.getSellDetail(gftId,userId);
    }
}
