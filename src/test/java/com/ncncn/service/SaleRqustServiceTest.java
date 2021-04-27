package com.ncncn.service;

import java.util.*;

import com.ncncn.domain.GifticonVO;
import com.ncncn.domain.SaleRqustVO;
import com.ncncn.domain.pagination.SaleRqustCriteria;
import com.ncncn.mapper.GifticonMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;

import static org.junit.Assert.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@RunWith(MockitoJUnitRunner.class)
public class SaleRqustServiceTest {

	@Mock
	private GifticonMapper gifticonMapper;

	@InjectMocks
	private SaleRqustServiceImpl saleRqustService;

	@Test
	public void getAllRqustSuccessTest() {
		List<SaleRqustVO> result = new ArrayList<>();
		when(gifticonMapper.readAllRqustWithPaging(any())).thenReturn(result);

		List<SaleRqustVO> rqustVOList = saleRqustService.getAllRqust(any(SaleRqustCriteria.class));

		verify(gifticonMapper).readAllRqustWithPaging(any());
		assertEquals(rqustVOList, result);
	}

	@Test(expected = NullPointerException.class)
	public void getRqustByIdThrowNullPointerExceptionWhenMapIsNullTest() {
		when(gifticonMapper.readRqustById(anyInt())).thenReturn(null);

		Map<String, Object> saleRqust = saleRqustService.getRqustById(anyInt());
	}

	@Test(expected = NullPointerException.class)
	public void getRqustByIdThrowNullPointerExceptionWhenIsEmptyTest() {
		when(gifticonMapper.readRqustById(anyInt())).thenReturn(new HashMap<>());

		Map<String, Object> saleRqust = saleRqustService.getRqustById(anyInt());
	}

	@Test(expected = NullPointerException.class)
	public void getRqustByIdThrowNullPointerExceptionWhenGifticonIsNullTest() {
		when(gifticonMapper.read(anyInt())).thenReturn(null);

		Map<String, Object> saleRqust = saleRqustService.getRqustById(anyInt());
	}

	@Test
	public void getRqustByIdSuccessTest() {
		Map<String, Object> result = new HashMap<>();
		result.put("test", "test");

		GifticonVO gifticonVO = new GifticonVO();
		gifticonVO.setExpirDt(new Date());
		gifticonVO.setInDate(new Date());

		when(gifticonMapper.readRqustById(anyInt())).thenReturn(result);
		when(gifticonMapper.read(anyInt())).thenReturn(gifticonVO);

		Map<String, Object> saleRqust = saleRqustService.getRqustById(anyInt());

		verify(gifticonMapper).readRqustById(anyInt());
		verify(gifticonMapper).read(anyInt());
		assertNotNull(saleRqust);
		assertFalse(saleRqust.isEmpty());
	}

	@Test
	public void getTotalCountSuccessTest() {
		when(gifticonMapper.countAllRqust(new SaleRqustCriteria())).thenReturn(1);

		int total = saleRqustService.getTotalCount(new SaleRqustCriteria());

		verify(gifticonMapper).countAllRqust(any(SaleRqustCriteria.class));
		assertEquals(1, total);
	}

	@Test
	public void modifyStusCodeAndAprvDtSuccessTest() {
		when(gifticonMapper.updateStusCodeAndAprvDt(anyInt())).thenReturn(1);

		int result = saleRqustService.modifyStusCodeAndAprvDt(anyInt());

		verify(gifticonMapper).updateStusCodeAndAprvDt(anyInt());
		assertEquals(1, result);
	}
}
