package com.ncncn.mapper;

import com.ncncn.domain.StatisticsVO;

public interface StatisticsMapper {

	StatisticsVO readByToday();

	void initStatistics();

	int updateVisitrRec(int visitrRec);

	int updateSalesRec(StatisticsVO stat);
}
