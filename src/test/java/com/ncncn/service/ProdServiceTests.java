package com.ncncn.service;

import com.ncncn.domain.CategoryVO;
import com.ncncn.mapper.GifticonMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

@RunWith(MockitoJUnitRunner.class)
public class ProdServiceTests {

	@Mock
	private GifticonMapper giftiMapper;

	@Test
	public void test() {
		CategoryServiceImpl cateService = mock(CategoryServiceImpl.class);

		CategoryVO cate = new CategoryVO();   // mock 객체 생성

		when(cateService.getCate("010101")).thenReturn(cate);    // getCate() 호출 시

	}
}
