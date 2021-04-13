package com.ncncn.mapper;

import com.ncncn.domain.MyDealsDTO;
import org.apache.ibatis.annotations.Param;

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

    public int countStus001N002(@Param("userId") int userId,
                                @Param("stusName") String stusName);
}
