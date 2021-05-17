package com.ncncn.mapper;

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

	void initStatistics();

	int updateVisitrRec(int visitrRec);

	int updateSalesRec(StatisticsVO stat);
}
