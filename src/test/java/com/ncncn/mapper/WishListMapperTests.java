package com.ncncn.mapper;

import com.ncncn.domain.WishListVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static junit.framework.TestCase.assertEquals;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/applicationContext.xml")
@Log4j
public class WishListMapperTests {

	@Setter(onMethod_ = @Autowired)
	private WishListMapper mapper;

	@Test
	public void testCreate(){
		WishListVO wish = new WishListVO();

		wish.setUserId(1);
		wish.setProdCode("010103");

		mapper.insertWish(wish);
	}

	@Test
	public void testSelect(){
		WishListVO wish = new WishListVO();

		wish.setUserId(1);
		wish.setProdCode("010101");

		int hasWish = mapper.hasWish(wish);
		log.info(hasWish);

		assertEquals(hasWish, 1);
	}

	@Test
	public void testDelete(){
		WishListVO wish = new WishListVO();

		wish.setUserId(1);
		wish.setProdCode("010101");

		mapper.deleteWish(wish);
	}
}
