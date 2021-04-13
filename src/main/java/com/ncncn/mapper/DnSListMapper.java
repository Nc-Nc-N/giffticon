package com.ncncn.mapper;

import com.ncncn.domain.CriteriaSM;
import com.ncncn.domain.DealDetailVO;
import com.ncncn.domain.GifticonVO;
import com.ncncn.domain.MyDealsDTO;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.Date;
import java.util.List;

public interface DnSListMapper {


//    public List<MyDealsDTO> getDeals(String email);

    public List<MyDealsDTO> getGftDetail(int gftId);

    public List<MyDealsDTO> getDealsWithPaging(@Param("email") String email,
                                               @Param("dateFrom") String dateFrom,
                                               @Param("dateTo") String dateTo,
                                               @Param("amount") int amount,
                                               @Param("pageNum") int pageNum,
                                               @Param("keyword") String keyword,
                                               @Param("type") String type,
                                               @Param("typeArr") String[] typeArr);

    public int countDealList(@Param("email") String email,
                             @Param("dateFrom") String dateFrom,
                             @Param("dateTo") String dateTo,
                             @Param("keyword") String keyword,
                             @Param("type") String type,
                             @Param("typeArr") String[] typeArr);

    public int countStus004(int userId);
}
