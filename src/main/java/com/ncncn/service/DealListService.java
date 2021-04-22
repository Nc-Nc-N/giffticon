package com.ncncn.service;

import com.ncncn.domain.pagination.CriteriaSM;
import com.ncncn.domain.MyDealsDTO;

import java.util.List;

public interface DealListService {

    public List<MyDealsDTO> getGftDetail(int gftId, int userId);

    public List<MyDealsDTO> getDealsWithPaging(int userId, CriteriaSM cri);

    public int countDealList(int userId, CriteriaSM cri);

    public int countStus004(int userId);

}
