package com.ncncn.task;

import com.ncncn.domain.AutoPriceVO;
import com.ncncn.domain.GifticonVO;
import com.ncncn.domain.PrcUpdateVO;
import com.ncncn.mapper.GifticonMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Log4j
@Component
public class AutoPriceUpdateTask {

    @Setter(onMethod_ = {@Autowired})
    private GifticonMapper gifticonMapper;

    // 매일 0시 0분 1초에 자동설정가격 업데이트
    @Transactional
    @Scheduled(cron="1 0 0 * * ?")
    public void updatePrices() {

        try {
            // 자동가격 설정된 기프티콘 중 자동할인율 변경구간(유효기간까지 59, 44, 29, 14일)에 해당되는 기프티콘 가져오기
            List<AutoPriceVO> list = gifticonMapper.getAutoPricedGifticon();
            log.info(list);
            GifticonVO gft = new GifticonVO();
            PrcUpdateVO prcUpdate = new PrcUpdateVO();
            for (AutoPriceVO gifticon : list) {
                // 1. 각각의 gifticon 현재 할인구간을 계산한다
                // 2. dc_prc와 dc_rate를 바꿔준다
                // 3. DB에 update한다
                int id = gifticon.getId();
                log.info("id: " + id);
                int prc = gifticon.getPrc();
                double inDcRate = gifticon.getInDcRate();
                Date expDt = gifticon.getExpirDt();

                double dcRate = getDcRate(expDt, inDcRate);

                int dcPrc = getDcPrc(prc, dcRate);

                if(dcPrc != gifticon.getDcPrc()) {
                    // 할인가격, 할인율 업데이트
                    AutoPriceVO autoPriceVO = new AutoPriceVO();
                    autoPriceVO.setId(id);
                    autoPriceVO.setDcPrc(dcPrc);
                    autoPriceVO.setDcRate(dcRate);
                    gifticonMapper.updateAutoPrice(autoPriceVO);
                    log.info("id: " + id + " newPrice: " + dcPrc + " newDcRate: " + dcRate);
                }

                prcUpdate.setGftId(id);
                updateDcPrcHistEndDt(prcUpdate);

                insertDcPrcHist(gft, id, prc);
            }
        } catch (Exception e) {
            e.printStackTrace();
            log.warn("자동설정가격 업데이트 과정에서 오류가 발생했습니다. 가격정보를 확인해주세요");
        }
    }

    private double getDcRate(Date expDt, double inDcRate) {
        Date today = new Date();
        long diffInMillies = expDt.getTime() - today.getTime();
        int dateDiff = (int)Math.ceil(diffInMillies/(1000 * 3600 * 24.0));

        log.info("dateDiff: " + dateDiff);

        // 할인율 구간 구분
        int interval = (int)(Math.ceil((60 - dateDiff) / 15.0));
        // 할인율 구간에 따른 추가할인율 계산 (5%, 10%, 15%, 20%)
        double addDcRate = interval * 0.05;
        // 상품 기본 할인율 + 추가할인율 -> 할인율
        double dcRate = inDcRate + addDcRate;
        // 부동소수점 제거
        dcRate = Math.floor(dcRate * 100) / 100;

        return dcRate;
    }

    // 자동입력가격은 할인율(기본할인율 + 날짜별 추가할인율) 적용 후 일의자리에서 반올림
    private int getDcPrc(int prc, double dcRate) {
        return (int)(Math.round(prc * (1 - dcRate) / 10.0) * 10);
    }

    // 현재 가격수정이력 row의 end_dt 컬럼에 변경시간을 입력하는 메서드
    private void updateDcPrcHistEndDt(PrcUpdateVO prcUpdate) {
        int gftIdForUpdate = gifticonMapper.getDcPrcHistIdByGftId(prcUpdate);
        gifticonMapper.updateDcPrcHist(gftIdForUpdate);
    }

    // 새로운 가격수정이력 row를 insert하는 메서드
    private void insertDcPrcHist(GifticonVO gifticon, int id, int dcPrc) {
        gifticon.setId(id);
        gifticon.setDcPrc(dcPrc);

        gifticonMapper.insertDcPrcHist(gifticon);
    }

}
