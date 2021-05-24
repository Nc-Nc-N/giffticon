package com.ncncn.task;

import com.ncncn.service.GftManagingService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.List;

@Log4j
@Component
public class AutoDealCmplTask {

    @Setter(onMethod_ = @Autowired)
    GftManagingService gftManagingService;

    @Scheduled(cron="1 0 0 * * ?")
    public void updateGftStatus(){

        //1. deal_detail에서 cmpl_dt가 null인 것들 찾아서 반환

        List<Integer> gftList = gftManagingService.getNotCmplGifticon();

        if(gftList.size() == 0){
            log.info("자동 구매확정할 기프티콘이 없습니다.");
        }else{
            log.info("총 " + gftList.size() + "개의 기프티콘을 구매확정 합니다.");

            System.out.println(gftList);
        }

        //중단 - gifticon mapper에 상태코드 update 문 넣는 중 파라미터를 gftLIst로 들어가게 해야함

        //2. 그 중 pymt_dt 익일 + 3이 now보다 같거나 이전인것듣만 뽑기
        //3. 이 gft들은 stus를 005로 변경 후 cmpl_dt now()로 update
        //4. gft 판매한 사람에게 해당 금액 넣어주기
    }
}
