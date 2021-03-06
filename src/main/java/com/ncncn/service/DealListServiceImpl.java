package com.ncncn.service;

import com.ncncn.domain.DealDetailVO;
import com.ncncn.domain.pagination.MyPageCriteria;
import com.ncncn.domain.MyDealsVO;
import com.ncncn.mapper.DealListMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j
@Service
@AllArgsConstructor
public class DealListServiceImpl implements DealListService {

    private DealListMapper dealListMapper;

    @Override
    public MyDealsVO getGftDetail(int gftId, int userId) {

        log.info("Get Detail of gft Id: " + gftId);

        MyDealsVO mydeal = dealListMapper.getGftDetail(gftId, userId);

        if(mydeal == null){
            throw new NullPointerException("해당아이디의 기프티콘이 아닙니다.");
        }

        return mydeal;
    }

    @Override
    public List<MyDealsVO> getDealsWithPaging(int userId, MyPageCriteria cri) {
        log.info("Service of Get Deals with Paging....");

        return dealListMapper.getDealsWithPaging(userId, cri.getDateFrom(), cri.getDateTo(),
                cri.getAmount(), cri.getPageNum(), cri.getKeyword(), cri.getType(), cri.getTypeArr());
    }

    @Override
    public int countDealList(int userId, MyPageCriteria cri) {
        log.info("Count " + userId + "'s deal list....");

        return dealListMapper.countDealList(userId, cri.getDateFrom(), cri.getDateTo(),
                cri.getKeyword(), cri.getType(), cri.getTypeArr());
    }

    @Override
    public int countStus004(int userId) {

        log.info("Count status 004....");

        return dealListMapper.countStus004(userId);
    }

    @Override
    public int insertDeal(DealDetailVO dealDetailVO){

        log.info("insertDeal...");
        dealListMapper.insertDeal(dealDetailVO);
        return dealDetailVO.getId();
    }

}
