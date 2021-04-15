package com.ncncn.mapper;

import com.ncncn.domain.*;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/applicationContext.xml")
@Log4j
public class ProdMapperTests {

	@Setter(onMethod_ = @Autowired)
	private ProdMapper mapper;

	@Test
	public void testGetCate(){

		CategoryVO category = mapper.getCate("010101");
		log.info(category);

	}

	@Test
	public void testGetBrandList(){

		mapper.getBrandList("01").forEach(brand -> log.info(brand));

	}

	@Test
	public void testPaging(){

		GiftiCriteria prod = new GiftiCriteria();

		// 12개씩 2페이지
		prod.setPageNum(2);
		prod.setAmount(10);
		prod.setCode("01");
		prod.setOrderby("best");

		List<ProdListVO> list = mapper.getGiftiWithPaging(prod);
		list.forEach(gifti -> log.info(gifti));

	}

	@Test
	public void testSearch(){
		GiftiCriteria prod = new GiftiCriteria();

		prod.setKeyword("아메리카노");

		List<ProdListVO> list = mapper.getGiftiWithPaging(prod);

		list.forEach(gifti -> log.info(gifti));
	}

	@Test
	public void testGetGiftiList(){

		mapper.getGiftiList("010101").forEach(gifti -> log.info(gifti));
	}

	@Test
	public void testGetGifti(){

		ProdListVO gifti = mapper.getGifti("010101");
		log.info(gifti);

	}

	@Test
	public void testGetBestGifti(){
		mapper.getBestGifti().forEach(gifti -> log.info(gifti));
	}


}
