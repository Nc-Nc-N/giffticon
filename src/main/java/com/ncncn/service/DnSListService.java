package com.ncncn.service;

import com.ncncn.domain.CriteriaSM;
import com.ncncn.domain.MyDealsDTO;

import java.util.List;

public interface DnSListService {

//    public List<MyDealsDTO> getDeals(String email);

    public List<MyDealsDTO> getGftDetail(int gftId);

    public List<MyDealsDTO> getDealsWithPaging(String email, CriteriaSM cri);

    public int countDealList(String email, CriteriaSM cri);

    public int countStus004(int userId);

    public int countStus001N002(int userId, String stusName);
}
