package com.ncncn.mapper;

import com.ncncn.domain.WishListVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static junit.framework.TestCase.assertEquals;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/applicationContext.xml")
@Log4j
public class WishListMapperTests {

	@Setter(onMethod_ = @Autowired)
	private WishListMapper wishMapper;

	@Setter(onMethod_ = @Autowired)
	private GifticonMapper giftiMapper;

	@Test
	public void testInsertWish(){

		WishListVO wish = new WishListVO();

		wish.setUserId(160);
		wish.setProdCode("010203");

		int result = wishMapper.insertWish(wish);

		assertEquals(1, result);

		wishMapper.deleteWish(wish);
	}

	@Test
	public void testHasWish(){

		WishListVO wish = new WishListVO();

		wish.setUserId(160);
		wish.setProdCode("010102");

		wishMapper.insertWish(wish);

		int hasWish = wishMapper.hasWish(wish);

		assertEquals(hasWish, 1);

		wishMapper.deleteWish(wish);

		hasWish = wishMapper.hasWish(wish);

		assertEquals(hasWish, 0);
	}

	@Test
	public void testDelete(){

		WishListVO wish = new WishListVO();

		wish.setUserId(1);
		wish.setProdCode("010101");
		wishMapper.insertWish(wish);

		int result = wishMapper.deleteWish(wish);

		assertEquals(1, result);
	}

	@Test
	public void testGetWishList(){

		int userId = 160;
		List<WishListVO> list = wishMapper.getWishList(userId);
		int cnt = list.size();

		list.forEach(wish -> log.info(wish));

		assertEquals(160, list.get(0).getUserId());
		assertEquals("002", list.get(0).getGftStusCode());
	}

	@Test
	public void testGetWishListWithPaging(){

		int userId = 160;
		int amount = 4;
		int pageNum = 1;

		List<WishListVO> list = wishMapper.getWishListWithPaging(userId, amount, pageNum);

		list.forEach(gifti -> log.info(gifti));

		assertEquals(4, list.size());
	}
}
