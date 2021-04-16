package com.ncncn.service;

import com.ncncn.domain.StatisticsVO;
import com.ncncn.mapper.StatisticsMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;

import static org.junit.Assert.assertNotNull;
import static org.mockito.Mockito.*;

@RunWith(MockitoJUnitRunner.class)
public class StatisticsServiceTest {

	@Mock
	private StatisticsMapper statisticsMapper;

	@InjectMocks
	private StatisticsServiceImpl statisticsService;

	@Test(expected = NullPointerException.class)
	public void getByTodayThrowNullPointerExceptionTest() {
		when(statisticsMapper.readByToday()).thenReturn(null);

		StatisticsVO statisticsVO = statisticsService.getByToday();
	}

	@Test
	public void getByTodaySuccessTest() {
		when(statisticsMapper.readByToday()).thenReturn(mock(StatisticsVO.class));

		StatisticsVO statisticsVO = statisticsService.getByToday();

		verify(statisticsMapper).readByToday();
		assertNotNull(statisticsVO);
	}
}
