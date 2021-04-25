package com.ncncn.service;

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

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/applicationContext.xml")
@Log4j
public class DealServiceTests {

    @Setter(onMethod_ = {@Autowired})
    private ProductService service;

    @Setter(onMethod_ = {@Autowired})
    private CategoryService cateService;

    @Setter(onMethod_ = {@Autowired})
    private BrandService brandService;

    @Setter(onMethod_ = {@Autowired})
    private GifticonService giftiService;


    @Test
    public void testExists(){
        log.info(service);
        assertNotNull(service);
    }

    @Test
    public void testGetCategoryList() {
        List<CategoryVO> result = cateService.getCategoryList();
        log.info(result);
        assertEquals("01", result.get(0).getCode());
        assertEquals("02", result.get(1).getCode());
        assertEquals("03", result.get(2).getCode());
    }

    @Test
    public void testGetBrandList() {
        List<BrandVO> result = brandService.getBrandList("카페");
        log.info(result);
        assertEquals("0101", result.get(0).getCode());
        assertEquals("0102", result.get(1).getCode());
        assertEquals("0103", result.get(2).getCode());
    }

    @Test
    public void testGetBrandList2() {
        List<BrandVO> result = brandService.getBrandList("편의점, 마트");
        log.info(result);
        assertEquals("0201", result.get(0).getCode());
        assertEquals("0202", result.get(1).getCode());
        assertEquals("0203", result.get(2).getCode());
    }

    @Test
    public void testGetProductList() {
        List<ProductVO> result = service.getProductList("스타벅스");
        log.info(result);
        assertEquals("010101", result.get(0).getCode());
        assertEquals("010102", result.get(1).getCode());
        assertEquals("010103", result.get(2).getCode());
    }

    @Test
    public void testGetProductList2() {
        List<ProductVO> result = service.getProductList("GS25");
        log.info(result);
        assertEquals("020201", result.get(0).getCode());
        assertEquals("020202", result.get(1).getCode());
        assertEquals("020203", result.get(2).getCode());
    }

    @Test
    public void testGetProductObject() {
        ProductVO result = service.getProductObject("스타벅스", "카페아메리카노 T");
        log.info(result);
        assertEquals("010101", result.getCode());
    }

    @Test
    public void testGetProductObject2() {
        ProductVO result = service.getProductObject("스타벅스", "카페아메리카노 T");
        log.info(result);
        assertNotEquals("010102", result.getCode());
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
        gifticon.setBrcd("3422400000234234");
        gifticon.setDescn("설명");
        gifticon.setImgPath("/resources/testtestest");
        gifticon.setIsAutoPrc('0');
        gifticon.setGftStusCode("001");

        giftiService.registerGifticon(gifticon);
        log.info(gifticon);
    }

}
