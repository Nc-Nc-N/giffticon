package com.ncncn.mapper;

import com.ncncn.domain.DealDetailVO;
import com.ncncn.domain.GifticonVO;
import com.ncncn.domain.MyDealsDTO;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface DnSListMapper {


    public List<MyDealsDTO> getDeals(String email);

    public List<MyDealsDTO> getGftDetail(int gftId);
}
