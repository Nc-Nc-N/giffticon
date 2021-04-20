package com.ncncn.mapper;

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
public class GifticonMapperTests {

    @Setter(onMethod_ = @Autowired)
    GifticonMapper mapper;

    @Test
    public void gftDealCmplTest(){

        int gftId = 9999;

        int updateCmpl = mapper.gftDealCmpl(gftId);

        assertEquals(updateCmpl,0);
    }

//    @Test
//    public void deleteGifticonTest(){
//
//        int gftId = 56;
//
//        int deleteCmpl = mapper.deleteGifticon(gftId);
//
//        assertEquals(deleteCmpl, 1);
//    }

    @Test
    public void updateGftPrcTests(){

        int gftId = 152;
        char isAutoPrc = '1';
        int dcPrc = 5000;
        double dcRate = 0.20;
        int updatePrcCompl = mapper.updateGftPrc(gftId, isAutoPrc, dcPrc, dcRate);

        assertEquals(updatePrcCompl, 1);

    }

    @Test
    public void updateGftPrcTests2(){

        int gftId = 53;
        char isAutoPrfc = '0';
        int dcPrc = 10000;
        double dcRate = 0.10;
        int updatePrcCompl = mapper.updateGftPrc(gftId,isAutoPrfc,dcPrc,dcRate);

        assertEquals(updatePrcCompl, 1);

    }

    @Test
    public void countStus002Test(){

        String prodCode = "010101";

        int count = mapper.countOnselling(prodCode);

        assertEquals(count,3);
    }

}
