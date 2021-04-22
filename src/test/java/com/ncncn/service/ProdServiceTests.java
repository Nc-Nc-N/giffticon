package com.ncncn.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

@RunWith(MockitoJUnitRunner.class)
public class ProdServiceTests {

	@Mock
	private ProdMapper prodMapper;

	@Test
	public void test(){
		ProdServiceImpl service = mock(ProdServiceImpl.class);

		CategoryVO cate = new CategoryVO();   // mock 객체 생성

		when(service.getCate("010101")).thenReturn(cate);	// getCate() 호출 시

	}
}
