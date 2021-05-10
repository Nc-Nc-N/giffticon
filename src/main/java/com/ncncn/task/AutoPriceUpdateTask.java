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
import java.util.concurrent.TimeUnit;

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

        try {
            List<AutoPriceVO> list = gifticonMapper.getAutoPricedGifticon();
            log.info(list);
//        for(Map<String, String> gifticon : list) {
            for (AutoPriceVO gifticon : list) {
                // 1. 각각의 gifticon 현재 할인구간을 계산한다
                // 2. dc_prc와 dc_rate를 바꿔준다
                // 3. DB에 update한다
//                System.out.println(gifticon.getId());
                int id = gifticon.getId();
                log.info("id= " + id);
                int prc = gifticon.getPrc();
                double inDcRate = gifticon.getInDcRate();
                log.info("inDcRate= " + inDcRate);
                Date expDt = gifticon.getExpirDt();
                Date today = new Date();

                long diffInMillies = expDt.getTime() - today.getTime();
                long dateDiff = (int)Math.ceil(diffInMillies/(1000*3600*24.0));
                log.info("dateDiff = " + dateDiff);

                // 할인율 구간 구분
                int interval = (int)(Math.ceil((60 - dateDiff) / 15.0));
                log.info("interval= " + interval);
                // 할인율 구간에 따른 추가할인율 계산 (5%, 10%, 15%, 20%)
                double addDcRate = interval * 0.05;
                log.info("addDcRate= " + addDcRate);
                // 상품 기본 할인율 + 추가할인율 -> 할인율
                double dcRate = inDcRate + addDcRate;
                log.info("dcRate= " + dcRate);
                // 부동소수점 제거
                dcRate = Math.floor(dcRate * 100) / 100;
                log.info("AfterDcRate= " + dcRate);

                // 자동입력가격은 할인율(기본할인율 + 날짜별 추가할인율) 적용 후 일의자리에서 반올림
                int dcPrc = (int)(Math.round(prc * (1 - dcRate) / 10.0) * 10);

                if(dcPrc != gifticon.getDcPrc()) {
                    // 할인가격, 할인율 업데이트
                    // id, dcPrc, dcRate
                    AutoPriceVO autoPriceVO = new AutoPriceVO();
                    autoPriceVO.setId(id);
                    autoPriceVO.setDcPrc(dcPrc);
                    autoPriceVO.setDcRate(dcRate);
                    gifticonMapper.updateAutoPrice(autoPriceVO);
                    System.out.println("id: " + id + " newPrice: " + dcPrc + " dcRate: " + dcRate);
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
