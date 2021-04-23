package com.ncncn.mapper;

import com.ncncn.domain.pagination.MyPageCriteria;
import com.ncncn.domain.MyDealsVO;
import com.ncncn.domain.MySellVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.*;

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

        int userId = 156;
        MyPageCriteria cri = new MyPageCriteria(1,4);

        assertEquals(dealListMapper.countDealList(userId, cri.getDateFrom(), cri.getDateTo(),
                cri.getKeyword(), cri.getType(), cri.getTypeArr()), 12);

    }

    @Test
    public void testGetGftDetail() {

        int gftId = 80;
        int userId = 157;

        MyDealsVO dealDetail = dealListMapper.getGftDetail(gftId, userId).get(0);

        assertEquals(dealDetail.getBrdName(),"스타벅스");
        assertEquals(dealDetail.getGftId(), 80);
        assertEquals(dealDetail.getPrdName(),"카페아메리카노 T" );
        assertEquals(dealDetail.getStusCode(), "거래확정대기");
    }

    @Test
    public void testPaging() {
        MyPageCriteria cri = new MyPageCriteria();
//        cri.setDateFrom("2020-10-22");
//        cri.setDateTo("2021-03-22");
        cri.setPageNum(1);
        cri.setAmount(4);
//        cri.setKeyword("");
//        cri.setType("");
        String[] typeArr = cri.getTypeArr();

        int userId = 157;

        List<MyDealsVO> list = dealListMapper.getDealsWithPaging(userId, cri.getDateFrom(), cri.getDateTo(),
                cri.getAmount(), cri.getPageNum(), cri.getKeyword(), cri.getType(), typeArr);

        assertEquals(list.size(),4);
    }

    @Test
    public void testGetCount004() {

        int userId = 156;

        int count004 = dealListMapper.countStus004(userId);

        assertEquals(count004, 5);
    }

    @Test
    public void testCountStus001N002() {

        int userId = 156;

        int count002 = sellListMapper.countStus001N002(userId, "판매중");
        int count001 = sellListMapper.countStus001N002(userId, "판매대기");

        assertEquals(count002, 6);
        assertEquals(count001, 4);
    }

    @Test
    public void testGetSellListWithPaging(){

        int userId = 156;
        MyPageCriteria cri = new MyPageCriteria(1,4);
        MyPageCriteria cri2 = new MyPageCriteria(2,4);
        MyPageCriteria cri3 = new MyPageCriteria(3,4);

        List<MySellVO> sellList = sellListMapper.getSellsWithPaging(userId, cri.getDateFrom(), cri.getDateTo(),
                cri.getAmount(), cri.getPageNum(), cri.getKeyword(), cri.getType(), cri.getTypeArr());

        List<MySellVO> sellList2 = sellListMapper.getSellsWithPaging(userId, cri2.getDateFrom(), cri2.getDateTo(),
                cri2.getAmount(), cri2.getPageNum(), cri2.getKeyword(), cri2.getType(), cri2.getTypeArr());

        List<MySellVO> sellList3 = sellListMapper.getSellsWithPaging(userId, cri3.getDateFrom(), cri3.getDateTo(),
                cri3.getAmount(), cri3.getPageNum(), cri3.getKeyword(), cri3.getType(), cri3.getTypeArr());

        assertEquals(sellList.size(),4);
        assertEquals(sellList2.size(),4);
        assertEquals(sellList3.size(),3);
    }

    @Test
    public void testCountSellList(){

        int userId = 156;
        int userId2 = 157;

        MyPageCriteria cri = new MyPageCriteria(1,4);

        int countList = sellListMapper.countSellList(userId, cri.getDateFrom(), cri.getDateTo(),
                 cri.getKeyword(), cri.getType(), cri.getTypeArr());

        int countList2 = sellListMapper.countSellList(userId2, cri.getDateFrom(), cri.getDateTo(),
                cri.getKeyword(), cri.getType(), cri.getTypeArr());

        assertEquals(countList,11);
        assertEquals(countList2,8);

    }

    @Test
    public void testGetSellDetail(){

        int userId = 157;
        int gftId =  66;

        MySellVO sellDetail = sellListMapper.getSellDetail(gftId,userId).get(0);

        assertEquals(sellDetail.getDcPrc(), 6000);
//        assertEquals(sellDetail.getDcRate(),0.05d);
        assertEquals(sellDetail.getUserId(), 157);
    }
}
