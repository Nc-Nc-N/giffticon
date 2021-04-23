package com.ncncn.service;

import com.ncncn.mapper.PsnlQustMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;

import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@RunWith(MockitoJUnitRunner.class)
public class CsPsnlQustServiceTest {

	@Mock
	private PsnlQustMapper csPsnlQustMapper;

	@InjectMocks
	private PsnlQustServiceImpl csPsnlQustService;

	@Test
	public void countHaveNoAnsSuccessTest() {
		when(csPsnlQustMapper.countHaveNoAns()).thenReturn(0);

		int count = csPsnlQustService.countHaveNoAns();

		verify(csPsnlQustMapper).countHaveNoAns();
		assertEquals(0, count);
	}
}
