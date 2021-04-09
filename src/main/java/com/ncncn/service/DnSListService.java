package com.ncncn.service;

import com.ncncn.domain.GifticonVO;
import com.ncncn.domain.MyDealsDTO;

import java.util.List;

public interface DnSListService {

    public List<MyDealsDTO> getDeals(String email);

//    public List<GifticonVO> getDealDetails(int gifticonId);
}
