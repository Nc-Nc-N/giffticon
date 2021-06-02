package com.ncncn.task;

import com.ncncn.domain.DealDetailVO;
import com.ncncn.domain.GifticonVO;
import com.ncncn.domain.PntHistVO;
import com.ncncn.service.ConService;
import com.ncncn.service.GftManagingService;
import com.ncncn.service.GifticonService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;

@Log4j
@Component
public class AutoDealCmplTask {

    @Setter(onMethod_ = @Autowired)
    GftManagingService gftManagingService;

    @Setter(onMethod_ = @Autowired)
    GifticonService gifticonService;

    @Setter(onMethod_ = @Autowired)
    ConService conService;

    @Scheduled(cron="1 0 0 * * ?")
    public void updateGftStatus(){

        Date today = new Date();
        log.info("자동구매확정 실행....." + today);

        List<DealDetailVO> gftList = gftManagingService.getNotCmplGifticon();

        for(DealDetailVO dealDetailVO : gftList){

            dealDetailVO.setPymtPrc((int)(dealDetailVO.getPymtPrc()/100*90));

            GifticonVO gifticonVO = gifticonService.getGft(dealDetailVO.getGifticonId());

            //pnt_history 객체 만들기
            PntHistVO pntHistVO = new PntHistVO();
            pntHistVO.setUserId(gifticonVO.getUserId());
            pntHistVO.setChgQuty(dealDetailVO.getPymtPrc());
            pntHistVO.setDealId(dealDetailVO.getId());
            pntHistVO.setPntHistCode("004");

            // conHist insert
            conService.insertConHist(pntHistVO);
        }

        if(gftList.size() != 0){

            try{
                int isUpdated = gftManagingService.autoDealCmpl(gftList);
                log.info("자동구매확정 완료...");
            }catch (Exception e){
                log.info("자동 구매확정 오류 발생");
            }

        }else{
            log.info("상태변경할 기프티콘이 없습니다.");
        }

    }
}
