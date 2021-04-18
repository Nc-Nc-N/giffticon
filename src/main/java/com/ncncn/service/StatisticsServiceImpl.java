package com.ncncn.service;

import com.ncncn.domain.StatisticsVO;
import com.ncncn.mapper.StatisticsMapper;
import lombok.extern.log4j.Log4j;

import org.springframework.stereotype.Service;

@Service
@Log4j
public class StatisticsServiceImpl implements StatisticsService {

	private StatisticsMapper statisticsMapper;

	public StatisticsServiceImpl(StatisticsMapper statisticsMapper) {
		this.statisticsMapper = statisticsMapper;
	}

	@Override
	public StatisticsVO getByToday() {
		StatisticsVO statisticsVO = statisticsMapper.readByToday();

		if (statisticsVO == null) {
			throw new NullPointerException("금일 매출, 방문자 수 정보가 존재하지 않습니다.");
		}

		return statisticsVO;
	}
}
