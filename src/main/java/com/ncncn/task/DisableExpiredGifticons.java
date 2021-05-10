package com.ncncn.task;

import com.ncncn.mapper.GifticonMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Log4j
@Component
public class DisableExpiredGifticons {

    @Setter(onMethod_ = {@Autowired})
    private GifticonMapper gifticonMapper;

    // 매일 23시 55분에 유효기간 만료된 상품 판매불가로 변경
    @Scheduled(cron="0 * * * * *")
    public void updateGifticonStatus() throws Exception {

    }
}
