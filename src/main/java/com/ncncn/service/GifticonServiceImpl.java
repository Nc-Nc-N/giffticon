package com.ncncn.service;

import com.ncncn.domain.PrcUpdateVO;
import com.ncncn.domain.GifticonVO;
import com.ncncn.domain.ProdListVO;
import com.ncncn.domain.pagination.GiftiCriteria;

import com.ncncn.mapper.GifticonMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j
@Service
@AllArgsConstructor
public class GifticonServiceImpl implements GifticonService {

    GifticonMapper gifticonMapper;


    @Override
    public ProdListVO getGifticon(int id) {
        return gifticonMapper.getGifticon(id);
    }

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
    public int updateGftPrc(PrcUpdateVO prcUpdate) {

        return gifticonMapper.updateGftPrc(prcUpdate.getGftId(),prcUpdate.getIsAutoPrc(),prcUpdate.getDcPrc(), prcUpdate.getDcRate());
    }

    @Override
    public int countNotYetApproved() {
        return gifticonMapper.countNotYetApproved();
    }

    @Override
    public int countOnselling(String prdCode) {

        return gifticonMapper.countOnselling(prdCode);
    }

    @Override
    public List<ProdListVO> getGiftiWithPaging(GiftiCriteria cri) {

        return gifticonMapper.getGiftiWithPaging(cri);
    }

    @Override
    public int getTotal(GiftiCriteria cri) {

        return gifticonMapper.getTotalCount(cri);
    }

    @Override
    public List<ProdListVO> getGiftiList(String code) {

        return gifticonMapper.getGiftiList(code);
    }

    @Override
    public ProdListVO getGifti(String code) {

        return gifticonMapper.getGifti(code);
    }

    @Override
    public List<ProdListVO> getBestGifti() {

        return gifticonMapper.getBestGifti();
    }

    @Override
    public List<ProdListVO> getDeadlineGifti() {

        return gifticonMapper.getDeadlineGifti();
    }

    @Override
    public void registerGifticon(GifticonVO gifticon) {
        gifticonMapper.registerGifticon(gifticon);
    }

}
