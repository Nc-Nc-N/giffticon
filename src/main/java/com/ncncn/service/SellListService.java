package com.ncncn.service;

import com.ncncn.domain.pagination.MyPageCriteria;
import com.ncncn.domain.MySellVO;

import java.util.List;

public interface SellListService {

    public int countSellList(int userId, MyPageCriteria cri);

    public List<MySellVO> getSellsWithPaging(int userId, MyPageCriteria cri);

    public List<MySellVO> getSellDetail(int gftId, int userId);

    public int countStus001N002(int userId, String stusName);

}
