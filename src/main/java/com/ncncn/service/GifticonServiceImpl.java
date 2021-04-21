package com.ncncn.service;

import com.ncncn.mapper.GifticonMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;

@Log4j
@Service
@AllArgsConstructor
public class GifticonServiceImpl implements GifticonService {

    GifticonMapper gifticonMapper;

    @Override
    public int gftDealCmpl(int gftId) {

        log.info("Gifticon Deal Complete Service.....");

        return gifticonMapper.gftDealCmpl(gftId);
    }

    @Override
    public int deleteGifticon(int gftId) {

        log.info("delete GftId: " + gftId);

        return gifticonMapper.deleteGifticon(gftId);
    }

    @Override
    public int updateGftPrc(int gftId, char isAutoPrc, int dcPrc, double dcRate) {

        return gifticonMapper.updateGftPrc(gftId, isAutoPrc, dcPrc, dcRate);
    }

    @Override
    public int countNotYetApproved() {
        return gifticonMapper.countNotYetApproved();
    }

    @Override
    public int countOnselling(String prdCode) {

        return gifticonMapper.countOnselling(prdCode);
    }

}
