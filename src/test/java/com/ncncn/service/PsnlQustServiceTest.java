package com.ncncn.service;

import com.ncncn.domain.CsPsnlQustVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.assertNotNull;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/applicationContext.xml")
@Log4j
public class PsnlQustServiceTest {

	@Setter(onMethod_= {@Autowired} )
	private PsnlQustService service;

	@Test
	public void testExist(){

		log.info(service);
		assertNotNull(service);
	}

	@Test
	public void testRegister(){

		CsPsnlQustVO psnl = new CsPsnlQustVO();
		psnl.setTitle("새로 작성하는 글");
		psnl.setCntnt("새로 작성하는 내용");
		psnl.setCsCateCode("001");
		psnl.setUserId(156);
		psnl.setAtchFilePath("asd.jpg");
		psnl.setStusCode("000");

		service.register(psnl);
	}

}
