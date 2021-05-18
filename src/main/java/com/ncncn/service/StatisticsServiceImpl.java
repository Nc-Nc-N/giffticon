package com.ncncn.service;

import com.ncncn.domain.AdminCateSalesHistVO;
import com.ncncn.domain.AdminSalesHistVO;
import com.ncncn.domain.AdminVisitrHistVO;
import com.ncncn.domain.StatisticsVO;
import com.ncncn.mapper.StatisticsMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Log4j
public class StatisticsServiceImpl implements StatisticsService {

	@Setter(onMethod_ = {@Autowired})
	private StatisticsMapper statisticsMapper;

	public StatisticsServiceImpl(StatisticsMapper statisticsMapper) {
		this.statisticsMapper = statisticsMapper;
	}

	@Override
	public StatisticsVO getByToday() {

		if (statisticsMapper.readByToday() == null){

			statisticsMapper.initStatistics();

		}

		StatisticsVO statisticsVO = statisticsMapper.readByToday();

		if (statisticsVO == null) {
			throw new NullPointerException("금일 매출, 방문자 수 정보가 존재하지 않습니다.");
		}

		return statisticsVO;
	}

	@Override
	public List<AdminSalesHistVO> getSalesByMonth() {

		log.info("get SalesRec By Month");
		return statisticsMapper.readSalesByMonth();
	}

	@Override
	public List<AdminVisitrHistVO> getVisitrByMonth() {

		log.info("get Visitr By Month");
		return statisticsMapper.readVisitrByMonth();
	}

	@Override
	public List<AdminCateSalesHistVO> getCateSalesByMonth() {

		log.info("get Category Sales by Month");
		return statisticsMapper.readCateSalesByMonth();
	}

	@Override
	public void initializeStatistics() {

		log.info("initialize Statistice.......");
		statisticsMapper.initStatistics();
	}

	@Override
	public boolean modifyVisitrRec(int visitrRec) {

		log.info("modify VisitrRec....");
		return statisticsMapper.updateVisitrRec(visitrRec) == 1;
	}


	@Override
	public boolean modifySalesRec(StatisticsVO stat) {

		log.info("modify SalesRec...");
		return statisticsMapper.updateSalesRec(stat) == 1;
	}
}
