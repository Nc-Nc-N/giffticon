package com.ncncn.task;

import com.ncncn.domain.DealDetailVO;
import com.ncncn.domain.GifticonVO;
import com.ncncn.service.GftManagingService;
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

    @Scheduled(cron="1 0 0 * * ?")
    public void updateGftStatus(){

        Date today = new Date();
        log.info("자동구매확정 실행....." + today);

        List<DealDetailVO> gftList = gftManagingService.getNotCmplGifticon();

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
