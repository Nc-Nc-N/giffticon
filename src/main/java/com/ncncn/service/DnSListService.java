package com.ncncn.service;

import com.ncncn.domain.CriteriaSM;
import com.ncncn.domain.GifticonVO;
import com.ncncn.domain.MyDealsDTO;

import java.util.List;

public interface DnSListService {

//    public List<MyDealsDTO> getDeals(String email);

    public List<MyDealsDTO> getGftDetail(int gftId);

    public List<MyDealsDTO> getDealsWithPaging(String email, CriteriaSM cri);

    public int countDealList(String email, CriteriaSM cri);

    public void countStus004(int userId);
    }
}
