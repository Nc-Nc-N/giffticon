package com.ncncn.service;

import com.ncncn.domain.AdminCateSalesHistVO;
import com.ncncn.domain.AdminSalesHistVO;
import com.ncncn.domain.AdminVisitrHistVO;
import com.ncncn.domain.StatisticsVO;

import java.util.List;

public interface StatisticsService {

	StatisticsVO getByToday();

	//월별 매출액
	List<AdminSalesHistVO> getSalesByMonth();

	//월별 방문자 수
	List<AdminVisitrHistVO> getVisitrByMonth();

	//월별 카테고리 매출액
	List<AdminCateSalesHistVO> getCateSalesByMonth();

	void initializeStatistics();

	public boolean modifyVisitrRec(int visitrRec);

	public boolean modifySalesRec(StatisticsVO stat);
}
