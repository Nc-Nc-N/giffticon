package com.ncncn.service;

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
public class GifticonServiceTests {

    @Setter(onMethod_ = {@Autowired})
    GifticonService gifticonService;

    @Test
    public void gftDealCmplTests(){

        int gftId = 51;

        gifticonService.gftDealCmpl(gftId);
    }

    @Test
    public void DeleteGifticonTests(){

        int gftId = 123;

        String msg =  gifticonService.deleteGifticon(123) == 1 ? "delete done" : "delete failed";

        log.info(msg);
    }

    @Test
    public void UpdateGifticonTests(){

        int gftId = 5;
        char isAutoPrc = '0';
        int dcPrc = 3000;

        gifticonService.updateGftPrc(gftId, isAutoPrc, dcPrc);
    }
}
