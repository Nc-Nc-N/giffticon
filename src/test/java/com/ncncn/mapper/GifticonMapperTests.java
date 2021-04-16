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
public class GifticonMapperTests {

    @Setter(onMethod_ = @Autowired)
    GifticonMapper mapper;

    @Test
    public void gftDealCmplTest(){

        int gftId = 103;

        mapper.gftDealCmpl(gftId);
    }

    @Test
    public void deleteGifticonTest(){

        int gftId = 125;

        mapper.deleteGifticon(gftId);
    }

    @Test
    public void updateGftPrcTests(){

        int gftId = 5;
        char isAutoPrc = '1';
        int dcPrc = 1800;

        mapper.updateGftPrc(gftId, isAutoPrc, dcPrc);
    }

}
