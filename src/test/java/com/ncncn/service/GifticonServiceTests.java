package com.ncncn.service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.assertEquals;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/applicationContext.xml")
@Log4j
public class GifticonServiceTests {

    @Setter(onMethod_ = {@Autowired})
    GifticonService gifticonService;

    @Test
    public void gftDealCmplTests(){

        int gftId = 51;

        int dealCmpl = gifticonService.gftDealCmpl(gftId);

        assertEquals(dealCmpl, 1);
    }

    @Test
    public void DeleteGifticonTests(){


        String msg =  gifticonService.deleteGifticon(123) == 1 ? "delete done" : "delete failed";
        String msg2 =  gifticonService.deleteGifticon(0000) == 1 ? "delete done" : "delete failed";
        String msg3 =  gifticonService.deleteGifticon(1) == 1 ? "delete done" : "delete failed";

        log.info(msg);

        assertEquals(msg,"delete failed");
        assertEquals(msg2,"delete failed");
        assertEquals(msg3,"delete done");
    }

    @Test
    public void UpdateGifticonTests(){

        int gftId = 94;
        char isAutoPrc = '0';
        int dcPrc = 2000;
        double dcRate = 0.10;
        int updatedCmpl = gifticonService.updateGftPrc(gftId, isAutoPrc, dcPrc, dcRate);

        assertEquals(updatedCmpl, 1);
    }

    @Test
    public void CountOnSellingTests(){

        String prdCode = "010104";

        int count = gifticonService.countOnselling(prdCode);

        assertEquals(count,4);
    }
}
