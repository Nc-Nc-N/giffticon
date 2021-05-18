package com.ncncn.task;

import com.ncncn.domain.GifticonVO;
import com.ncncn.mapper.GifticonMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;

@Log4j
@Component
public class DisableExpiredGifticons {

    @Setter(onMethod_ = {@Autowired})
    private GifticonMapper gifticonMapper;

    // 매일 23시 55분에 유효기간 만료된 상품 판매불가로 변경
    @Scheduled(cron="0 55 23 * * ?")
    public void updateGifticonStatus() {
        // 상태코드 001 or 002인 기프티콘 가져오기
        // 유효기간이 오늘이면 상태코드 003으로 변경
        try {
            List<GifticonVO> list = gifticonMapper.getOnSaleGifticon();
            for (GifticonVO gifticon : list) {

                int dateDiff = getDateDiff(gifticon.getExpirDt());

                if(dateDiff == 0) {
                    System.out.println("disable gifticon ID: " + gifticon.getId());
                    gifticonMapper.disableExpiredGifticon(gifticon.getId());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            log.warn("유효기간 만료 처리 과정에서 오류가 발생했습니다. 기프티콘 상태 정보를 확인해주세요.");
        }

    }

    private int getDateDiff(Date expDt) {
        Date today = new Date();

        long diffInMillies = expDt.getTime() - today.getTime();
        return (int)Math.ceil(diffInMillies/(1000 * 3600 * 24.0));
    }

}
