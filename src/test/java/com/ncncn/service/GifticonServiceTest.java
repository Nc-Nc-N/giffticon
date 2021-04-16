package com.ncncn.service;

import com.ncncn.mapper.GifticonMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;

import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@RunWith(MockitoJUnitRunner.class)
public class GifticonServiceTest {

	@Mock
	private GifticonMapper gifticonMapper;

	@InjectMocks
	private GifticonServiceImpl gifticonService;

	@Test
	public void countNotYetApprovedSuccessTest() {
		when(gifticonMapper.countNotYetApproved()).thenReturn(0);

		int count = gifticonService.countNotYetApproved();

		verify(gifticonMapper).countNotYetApproved();
		assertEquals(0, count);
	}
}
