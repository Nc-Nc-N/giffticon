package com.ncncn.mapper;

import com.ncncn.domain.MySellVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SellListMapper {

    public int countSellList(@Param("userId") int userId,
                             @Param("dateFrom") String dateFrom,
                             @Param("dateTo") String dateTo,
                             @Param("keyword") String keyword,
                             @Param("type") String type,
                             @Param("typeArr") String[] typeArr);

    public List<MySellVO> getSellsWithPaging(@Param("userId") int userId,
											 @Param("dateFrom") String dateFrom,
											 @Param("dateTo") String dateTo,
											 @Param("amount") int amount,
											 @Param("pageNum") int pageNum,
											 @Param("keyword") String keyword,
											 @Param("type") String type,
											 @Param("typeArr") String[] typeArr);

    public MySellVO getSellDetail(@Param("gftId") int gftId,
										@Param("userId") int userId);

    public int countStus001N002(@Param("userId") int userId,
                                @Param("stusName") String stusName);
}
