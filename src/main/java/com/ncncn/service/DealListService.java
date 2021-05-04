package com.ncncn.service;

import com.ncncn.domain.pagination.MyPageCriteria;
import com.ncncn.domain.MyDealsVO;

import java.util.List;

public interface DealListService {

    public MyDealsVO getGftDetail(int gftId, int userId);

    public List<MyDealsVO> getDealsWithPaging(int userId, MyPageCriteria cri);

    public int countDealList(int userId, MyPageCriteria cri);

    public int countStus004(int userId);

}
