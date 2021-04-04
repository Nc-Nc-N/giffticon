package com.ncncn.mapper;

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
public class DealMapperTests {
    @Setter(onMethod_ = @Autowired)
    private DealMapper mapper;

    @Test
    public void testGetCategoryList() {
        mapper.getCategoryList().forEach(deal -> log.info(deal));
    }

    @Test
    public void testGetBrandList() {
        mapper.getBrandList().forEach(deal -> log.info(deal));
    }

    @Test
    public void testGetProductList() {
        mapper.getProductList().forEach(deal -> log.info(deal));
    }
}
