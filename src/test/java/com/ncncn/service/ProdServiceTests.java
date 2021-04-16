package com.ncncn.service;

import com.ncncn.domain.GiftiCriteria;
import com.ncncn.service.ProdService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/applicationContext.xml")
@Log4j
public class ProdServiceTests {

	@Setter(onMethod_ = {@Autowired} )
	private ProdService service;

	@Test
	public void testgetGiftiWithPaging(){
		service.getGiftiWithPaging(new GiftiCriteria(2,10,"01","best")).forEach(prod->log.info(prod));
	}

	@Test
	public void testgetGifti(){
		service.getGiftiList("010101").forEach(gifti->log.info(gifti));
	}
}
