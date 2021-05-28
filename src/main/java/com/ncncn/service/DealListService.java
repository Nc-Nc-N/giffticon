package com.ncncn.service;

import com.ncncn.domain.DealDetailVO;
import com.ncncn.domain.pagination.MyPageCriteria;
import com.ncncn.domain.MyDealsVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface DealListService {

    public MyDealsVO getGftDetail(int gftId, int userId);

    public List<MyDealsVO> getDealsWithPaging(int userId, MyPageCriteria cri);

    public int countDealList(int userId, MyPageCriteria cri);

    public int countStus004(int userId);

    // 구매하기 이후 거래확정 대기
    public int insertDeal(DealDetailVO dealDetailVO);

}
