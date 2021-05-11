package com.ncncn.service;

import com.ncncn.domain.StatisticsVO;

public interface StatisticsService {

	StatisticsVO getByToday();

	void initializeStatistics();

	public boolean modifyVisitrRec(int visitrRec);

	public boolean modifySalesRec(StatisticsVO stat);
}
