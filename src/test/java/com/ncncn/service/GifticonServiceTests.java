package com.ncncn.service;

import com.ncncn.domain.DealDetailVO;
import com.ncncn.domain.GifticonVO;
import com.ncncn.domain.PrcUpdateVO;
import com.ncncn.domain.ProdListVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.assertEquals;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/applicationContext.xml")
@Log4j
public class GifticonServiceTests {

    @Setter(onMethod_ = {@Autowired})
    GifticonService gifticonService;

    @Setter(onMethod_ = {@Autowired})
    GftManagingService gftManagingService;

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

        PrcUpdateVO prcUpdate = new PrcUpdateVO();
        prcUpdate.setGftId(94);
        prcUpdate.setIsAutoPrc('0');
        prcUpdate.setDcPrc(2000);
        prcUpdate.setDcRate(0.10);

        int updatedCmpl = gifticonService.updateGftPrc(prcUpdate);

        assertEquals(updatedCmpl, 1);
    }

    @Test
    public void CountOnSellingTests(){

        String prdCode = "010104";

        int count = gifticonService.countOnselling(prdCode);

        assertEquals(count,4);
    }

    @Test
    public void getMainGftByBrdNameTest(){

        String brdName = "스타벅사";

        List<ProdListVO> gftList = gifticonService.getMainGftByBrandName(brdName);

        assertEquals(gftList.size(), 0);
    }

    @Test
    public void getNotCmplGftTest(){

        List<DealDetailVO> gftList = gftManagingService.getNotCmplGifticon();

        if(gftList.size() == 0){
            log.info("업데이트 할 기프티콘이 없습니다.");
        }else{
            log.info("총 " + gftList.size() + "개의 gft 업데이트");
            log.info(gftList);
        }


    }
}
