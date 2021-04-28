package com.ncncn.mapper;

import com.ncncn.domain.BrandVO;
import com.ncncn.domain.CategoryVO;
import com.ncncn.domain.ProdListVO;
import com.ncncn.domain.pagination.GiftiCriteria;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.assertTrue;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/applicationContext.xml")
@Log4j
public class ProdMapperTests {

	@Setter(onMethod_ = @Autowired)
	private GifticonMapper mapper;

	@Setter(onMethod_ = @Autowired)
	private CategoryMapper cateMapper;

	@Setter(onMethod_ = @Autowired)
	private BrandMapper brandMapper;


	@Test
	public void testGetCate(){

		CategoryVO cafe = cateMapper.getCate("010101");
		CategoryVO cafe1 = cateMapper.getCate("0101");
		CategoryVO cafe2 = cateMapper.getCate("01");


		// 01로 시작하는 코드는 카페
		assertThat(cafe.getName(), is("카페"));
		assertThat(cafe1.getName(), is("카페"));
		assertThat(cafe2.getName(), is("카페"));

		CategoryVO market = cateMapper.getCate("020201");
		CategoryVO market1 = cateMapper.getCate("0201");
		CategoryVO market2 = cateMapper.getCate("02");

		// 02로 시작하는 코드는 편의점
		assertThat(market.getName(), is("편의점, 마트"));
		assertThat(market1.getName(), is("편의점, 마트"));
		assertThat(market2.getEnabled(), is('1'));
	}

	@Test
	public void testGetBrandList(){

		List<BrandVO> cafeList = brandMapper.getBrandList("01");
		List<BrandVO> marketList = brandMapper.getBrandList("020202");

		int cafeCnt = 15;
		int marketCnt = 6;

		// 카페 브랜드 수 15
		assertThat(cafeList.size(), is(cafeCnt));

		// 편의점, 마트 브랜드 수 6
		assertThat(marketList.size(), is(marketCnt));

	}

	@Test
	public void testPaging(){

		GiftiCriteria prod = new GiftiCriteria();

		// 12개씩 2페이지
		prod.setPageNum(2);
		prod.setAmount(12);
		prod.setCode("01");
		prod.setOrderby("best");

		List<ProdListVO> list = mapper.getGiftiWithPaging(prod);
		list.forEach(gifti -> log.info(gifti));

		GiftiCriteria prod2 = new GiftiCriteria();

		// 12개씩 1페이지
		prod2.setPageNum(1);
		prod2.setAmount(12);
		prod2.setCode("02");
		prod2.setOrderby("low");

		List<ProdListVO> list2 = mapper.getGiftiWithPaging(prod2);
		list2.forEach(gifti -> log.info(gifti));

	}

	@Test
	public void testGetTotalCount(){
		GiftiCriteria prod = new GiftiCriteria();
		prod.setCode("010101");

		int total = mapper.getTotalCount(prod);

		assertThat(total, is(1));
	}

	@Test
	public void testSearch(){
		GiftiCriteria prod = new GiftiCriteria();

		prod.setKeyword("아메리카노");
		List<ProdListVO> list = mapper.getGiftiWithPaging(prod);
		list.forEach(gifti -> log.info(gifti));

		prod.setKeyword("스타");
		List<ProdListVO> list2 = mapper.getGiftiWithPaging(prod);
		list2.forEach(gifti -> log.info(gifti));

		prod.setKeyword("sadkfjskdlfj");
		List<ProdListVO> list3 = mapper.getGiftiWithPaging(prod);
		list3.forEach(gifti -> log.info(gifti));
	}

	@Test
	public void testGetGiftiList(){

		String code="010102";
		List<ProdListVO> list = mapper.getGiftiList(code);

		list.forEach(gifti -> log.info(gifti));

		assertThat(list.get(0).getProdCode(), is(code));
		assertThat(list.get(1).getGftStusCode(), is("002"));

	}

	@Test
	public void testGetGifti(){
		List<ProdListVO> list = mapper.getGiftiList("010101");
		ProdListVO gifti = mapper.getGifti("010101");
		int minPrc = list.get(0).getDcPrc();

		log.info(gifti);

		assertThat(gifti.getDcPrc(), is(minPrc));
	}

	@Test
	public void testGetBestGifti(){

		List<ProdListVO> list = mapper.getBestGifti();
		int soldQuty1 = list.get(0).getSoldQuty();
		int soldQuty2 = list.get(1).getSoldQuty();

		list.forEach(gifti -> log.info(gifti));

		assertTrue(soldQuty1>soldQuty2);
	}

	@Test
	public void testGetDeadLineGifti(){

		List<ProdListVO> list = mapper.getDeadlineGifti();
		int dDay1 = list.get(0).getDDay();
		int dDay2 = list.get(7).getDDay();
		String stuCode1 = list.get(3).getGftStusCode();

		list.forEach(gifti->log.info(gifti));

		assertTrue(dDay1<7);
		assertTrue(dDay2<7);
		assertThat(stuCode1, is("002"));

	}

}
