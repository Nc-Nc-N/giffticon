package com.ncncn.mapper;

import com.ncncn.domain.MyDealsDTO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface DealListMapper {


//    public List<MyDealsDTO> getDeals(String email);

    public List<MyDealsDTO> getGftDetail(@Param("gftId") int gftId, @Param("userId") int userId);

    public List<MyDealsDTO> getDealsWithPaging(@Param("userId") int userId,
                                               @Param("dateFrom") String dateFrom,
                                               @Param("dateTo") String dateTo,
                                               @Param("amount") int amount,
                                               @Param("pageNum") int pageNum,
                                               @Param("keyword") String keyword,
                                               @Param("type") String type,
                                               @Param("typeArr") String[] typeArr);

    public int countDealList(@Param("userId") int userId,
                             @Param("dateFrom") String dateFrom,
                             @Param("dateTo") String dateTo,
                             @Param("keyword") String keyword,
                             @Param("type") String type,
                             @Param("typeArr") String[] typeArr);

    public int countStus004(int userId);

}
