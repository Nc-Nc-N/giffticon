package com.ncncn.service;

import java.util.List;
import java.util.Map;

import com.ncncn.domain.DealDetailVO;
import com.ncncn.domain.GifticonVO;
import com.ncncn.domain.PrcUpdateVO;
import com.ncncn.domain.SaleRqustVO;
import com.ncncn.domain.pagination.SaleGftCriteria;
import com.ncncn.domain.pagination.SaleRqustCriteria;
import com.ncncn.mapper.GifticonMapper;
import com.ncncn.mapper.ProductMapper;
import lombok.extern.log4j.Log4j;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

@Service
@Log4j
public class GftManagingServiceImpl implements GftManagingService {

    private GifticonMapper gifticonMapper;

    private ProductMapper productMapper;

    public GftManagingServiceImpl(GifticonMapper gifticonMapper, ProductMapper productMapper) {
        this.gifticonMapper = gifticonMapper;
        this.productMapper = productMapper;
    }

    @Override
    public List<SaleRqustVO> getAllRqust(SaleRqustCriteria cri) {
        return gifticonMapper.readAllRqustWithPaging(cri);
    }

    @Override
    public Map<String, Object> getRqustById(int id) {
        Map<String, Object> saleRqust = gifticonMapper.readRqustById(id);

        if (saleRqust == null || saleRqust.size() == 0) {
            log.warn("해당 판매요청이 존재하지 않습니다.");
            throw new NullPointerException("해당 판매요청이 존재하지 않습니다.");
        }

        return saleRqust;
    }

    @Override
    public int getTotalCount(SaleRqustCriteria cri) {
        return gifticonMapper.countAllRqust(cri);
    }

    @Transactional(isolation = Isolation.READ_COMMITTED, rollbackFor = Exception.class)
    @Override
    public void approveRequest(int id, Map<String, String> rqust) {
        // 기프티콘 상태(판매요청 -> 판매중), 상품코드, 판매가, 할인율 변경
        gifticonMapper.updateSaleRqust(id, rqust.get("prodCode"), Integer.parseInt(rqust.get("dcPrc")), Double.parseDouble(rqust.get("dcRate")));
        productMapper.updateRegQuty(rqust.get("prodCode"));     // prodCode에 해당하는 상품의 기프티콘 개수  + 1

        PrcUpdateVO prcUpdate = new PrcUpdateVO();
        prcUpdate.setGftId(id);

        updateDcPrcHistEndDt(prcUpdate);
        insertDcPrcHist(id, Integer.parseInt(rqust.get("dcPrc")));

    }

    @Override
    public int removeRqust(int id) {
        return gifticonMapper.deleteGifticon(id);
    }

    @Override
    public List<Map<String, Object>> getAllSaleGifticon(SaleGftCriteria cri) {
        return gifticonMapper.getAllSaleGifticon(cri);
    }

    @Override
    public Map<String, Object> getSaleGifticon(int gftId) {
        return gifticonMapper.getSaleGifticon(gftId);
    }

    @Override
    public int getTotalSaleGftCount(SaleGftCriteria cri) {
        return gifticonMapper.countAllSaleGft(cri);
    }

    @Override
    public int modifyGftStus(int id, String stus) {
        return gifticonMapper.updateSaleGftStus(id, stus);
    }

    @Override
    public List<DealDetailVO> getNotCmplGifticon() {
        List<DealDetailVO> gftList = gifticonMapper.getNotCmplGft();
        return gftList;
    }

    @Override
    public int autoDealCmpl(List<DealDetailVO> gftList) {

        return gifticonMapper.autoDealCmpl(gftList); }

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
