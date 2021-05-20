package com.ncncn.mapper;

import com.ncncn.domain.AdminCateSalesHistVO;
import com.ncncn.domain.AdminSalesHistVO;
import com.ncncn.domain.AdminVisitrHistVO;
import com.ncncn.domain.StatisticsVO;

import java.util.List;


public interface StatisticsMapper {

	StatisticsVO readByToday();

	//월별 매출액
	List<AdminSalesHistVO> readSalesByMonth();

	//월별 방문자 수
	List<AdminVisitrHistVO> readVisitrByMonth();

	//월별 카테고리 매출액
	List<AdminCateSalesHistVO> readCateSalesByMonth();

	void initStatistics();

	int updateVisitrRec(int visitrRec);

	int updateSalesRec(StatisticsVO stat);
}
