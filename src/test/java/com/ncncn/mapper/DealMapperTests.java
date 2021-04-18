package com.ncncn.mapper;

import com.ncncn.domain.BrandVO;
import com.ncncn.domain.CategoryVO;
import com.ncncn.domain.GifticonVO;
import com.ncncn.domain.ProductVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotEquals;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/applicationContext.xml")
@Log4j
public class DealMapperTests {

    @Setter(onMethod_ = @Autowired)
    private DealMapper mapper;

    @Test
    public void testGetCategoryList() {
        List<CategoryVO> result = mapper.getCategoryList();
        log.info(result);
        assertEquals("01", result.get(0).getCode());
        assertEquals("02", result.get(1).getCode());
        assertEquals("03", result.get(2).getCode());
    }

    @Test
    public void testGetBrandList() {
        List<BrandVO> result = mapper.getBrandList("카페");
        log.info(result);
        assertEquals("0101", result.get(0).getCode());
        assertEquals("0102", result.get(1).getCode());
        assertEquals("0103", result.get(2).getCode());
    }

    @Test
    public void testGetBrandList2() {
        List<BrandVO> result = mapper.getBrandList("편의점, 마트");
        log.info(result);
        assertEquals("0201", result.get(0).getCode());
        assertEquals("0202", result.get(1).getCode());
        assertEquals("0203", result.get(2).getCode());
    }

    @Test
    public void testGetProductList() {
        List<ProductVO> result = mapper.getProductList("스타벅스");
        log.info(result);
        assertEquals("010101", result.get(0).getCode());
        assertEquals("010102", result.get(1).getCode());
        assertEquals("010103", result.get(2).getCode());
    }

    @Test
    public void testGetProductList2() {
        List<ProductVO> result = mapper.getProductList("GS25");
        log.info(result);
        assertEquals("020201", result.get(0).getCode());
        assertEquals("020202", result.get(1).getCode());
        assertEquals("020203", result.get(2).getCode());
    }

    @Test
    public void testGetProductObject() {
        String brdName="스타벅스";
        String prodName="카페아메리카노 T";
        log.info(mapper.getProductObject(brdName, prodName));

        assertEquals("010101", mapper.getProductObject(brdName, prodName).getCode());
    }

    @Test
    public void testGetProductObject2() {
        String brdName="투썸플레이스";
        String prodName="아메리카노 R";
        log.info(mapper.getProductObject(brdName, prodName));

        assertEquals("010201", mapper.getProductObject(brdName, prodName).getCode());
    }

    @Test
    public void testGetProductObject3() {
        String brdName="투썸플레이스";
        String prodName="아메리카노 R";
        log.info(mapper.getProductObject(brdName, prodName));

        assertNotEquals("010202", mapper.getProductObject(brdName, prodName).getCode() );
    }

    @Test
    public void registerGifticonTest() {
        GifticonVO gifticon = new GifticonVO();
        gifticon.setUserId(156);
        gifticon.setProdCode("010101");
        gifticon.setDcPrc(3900);
        gifticon.setDcRate(0.05);
        SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
        Date to = new Date();
        try {
            to = fm.parse("2021-07-22");
        } catch (Exception e) {
            e.printStackTrace();
        }
        gifticon.setExpirDt(to);
        gifticon.setBrcd("342241234324");
        gifticon.setDescn("설명");
        gifticon.setImgPath("/resources/asdsadsadsdwf");
        gifticon.setIsAutoPrc('0');
        gifticon.setGftStusCode("001");

        mapper.registerGifticon(gifticon);
        log.info(gifticon);
    }

}
