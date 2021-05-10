package com.ncncn.task;

import com.ncncn.domain.AutoPriceVO;
import com.ncncn.domain.GifticonVO;
import com.ncncn.mapper.GifticonMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Log4j
@Component
public class AutoPriceUpdateTask {

    @Setter(onMethod_ = {@Autowired})
    private GifticonMapper gifticonMapper;

    // 정가, 기본할인율, 유효기간을 입력받으면 자동할인된 가격을 반환하는 함수
    private int calculateAutoPrice(int prc, double in_dc_rate, Date expir_dt) {

        return 0;
    }

    // 정가, 기본할인율, 유효기간을 입력받으면 계산된 할인율을 반환하는 함수
    private double calculateDcRate(int prc, double in_dc_rate, Date expir_dt) {

        return 0;
    }

    @Scheduled(cron="0 * * * * *")
    public void updatePrices() throws Exception {

        List<AutoPriceVO> list = gifticonMapper.getAutoPricedGifticon();
        log.info(list);
//        for(Map<String, String> gifticon : list) {
        for(AutoPriceVO gifticon : list) {
            // 1. 각각의 gifticon 현재 할인구간을 계산한다
            // 2. dc_prc와 dc_rate를 바꿔준다
            // 3. DB에 update한다
//            System.out.println(gifticon.getId());
            Date expDt = gifticon.getExpirDt();

        }
    }
}
