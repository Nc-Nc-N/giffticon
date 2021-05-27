package com.ncncn.service;

import com.ncncn.domain.PrcUpdateVO;
import com.ncncn.domain.GifticonVO;
import com.ncncn.domain.ProdListVO;
import com.ncncn.domain.pagination.GiftiCriteria;

import com.ncncn.mapper.GifticonMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

    @Transactional
    @Override
    public int updateGftPrc(PrcUpdateVO prcUpdate) {

        int result =  gifticonMapper.updateGftPrc(prcUpdate.getGftId(),prcUpdate.getIsAutoPrc(),prcUpdate.getDcPrc(), prcUpdate.getDcRate());
        updateDcPrcHistEndDt(prcUpdate);
        insertDcPrcHist(prcUpdate.getGftId(), prcUpdate.getDcPrc());

        return result;
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

    @Transactional
    @Override
    public void registerGifticon(GifticonVO gifticon) {
        // gifticon 등록
        gifticonMapper.registerGifticon(gifticon);
        // 바코드번호로 등록된 기프티콘 id 가져오기
        String brcd = gifticon.getBrcd();
        int newId = gifticonMapper.getGftIdByBarcode(brcd);
        // gifticonVO에 가져온 id값 입력하고 dc_prc_hist table에 insert
        gifticon.setId(newId);
        gifticonMapper.insertDcPrcHist(gifticon);
    }

    @Override
    public List<ProdListVO> getMainGftByBrandName(String brdName){

        List<ProdListVO> mainGftList = gifticonMapper.getMainGftByBrandName(brdName);

        return mainGftList;
    }
    
  @Override
    public boolean updateGftStus(int id) {

        try{
            gifticonMapper.updateGftStus(id);
            log.info("기프티콘 상태코드 수정 성공(거래확정대기)");
            return true;
        } catch (Exception e){
            log.info("기프티콘 상태코드 수정 실패(거래확정대기)");
            return false;
        }
    }

    @Override
    public GifticonVO getGft(int gftId){

        GifticonVO gifticonVO = gifticonMapper.read(gftId);

        return gifticonVO;
    }

    @Override
    public int checkGft(int gftId, int userId) {
        return gifticonMapper.checkGft(gftId, userId);
    }

    // 현재 가격수정이력 row의 end_dt 컬럼에 변경시간을 입력하는 메서드
    private void updateDcPrcHistEndDt(PrcUpdateVO prcUpdate) {
        int gftIdForUpdate = gifticonMapper.getDcPrcHistIdByGftId(prcUpdate);
        gifticonMapper.updateDcPrcHist(gftIdForUpdate);
    }

    // 새로운 가격수정이력 row를 insert하는 메서드
    private void insertDcPrcHist(int id, int dcPrc) {
        GifticonVO gifticon = new GifticonVO();
        gifticon.setId(id);
        gifticon.setDcPrc(dcPrc);

        gifticonMapper.insertDcPrcHist(gifticon);
    }

}
