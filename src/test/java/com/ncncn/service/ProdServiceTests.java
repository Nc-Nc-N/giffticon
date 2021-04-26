package com.ncncn.service;

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

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

@RunWith(SpringJUnit4ClassRunner.class)
@Log4j
@ContextConfiguration("file:src/main/webapp/WEB-INF/applicationContext.xml")
public class ProdServiceTests {

	@Setter(onMethod_ = @Autowired)
	private CategoryService cateService;

	@Setter(onMethod_ = @Autowired)
	private BrandService brandService;

	@Setter(onMethod_ = @Autowired)
	private GifticonService giftiService;


	@Test
	public void testGetCate(){

		String code="0202";

		CategoryVO cate = cateService.getCate(code);

		log.info(cate);

		assertEquals("02", cate.getCode());
		assertEquals('1', cate.getEnabled());
	}

	@Test
	public void testGetBrandList(){

		String code="020101";

		List<BrandVO> marketList = brandService.getBrdList(code);

		assertEquals("02", marketList.get(0).getCateCode());
	}

	@Test
	public void testPaging(){

		GiftiCriteria cri = new GiftiCriteria(1,12,"0101","best");

		int cnt = giftiService.getGiftiWithPaging(cri).size();
		int soldQuty1 = giftiService.getGiftiWithPaging(cri).get(0).getSoldQuty();
		int soldQuty2 = giftiService.getGiftiWithPaging(cri).get(1).getSoldQuty();

		assertEquals(12, cnt);
		assertTrue(soldQuty1>soldQuty2);
	}

	@Test
	public void testSearch(){

		GiftiCriteria cri = new GiftiCriteria();

		cri.setKeyword("투썸");
		List<ProdListVO> list = giftiService.getGiftiWithPaging(cri);

		assertEquals("투썸플레이", list.get(0).getBname());
	}

	@Test
	public void testGetGiftiList(){

		String code = "0202";
		List<ProdListVO> list = giftiService.getGiftiList(code);

		assertEquals("GS25", list.get(0).getBname());
	}

	@Test
	public void testGetGifti(){

		String code = "010201";

		List<ProdListVO> list = giftiService.getGiftiList(code);
		ProdListVO gifti = giftiService.getGifti(code);
		int minPrc = list.get(0).getDcPrc();

		assertEquals(minPrc, gifti.getDcPrc());
	}

	@Test
	public void testGetBestGifti(){

		List<ProdListVO> list = giftiService.getBestGifti();
		int soldQuty1 = list.get(0).getSoldQuty();
		int soldQuty2 = list.get(1).getSoldQuty();

		assertTrue(soldQuty1>soldQuty2);
		assertEquals("002", list.get(0).getGftStusCode());
		assertEquals(8, list.size());
	}

	@Test
	public void testGetDeadLineGifti(){

		List<ProdListVO> list = giftiService.getDeadlineGifti();
		int dDay1 = list.get(0).getDDay();
		int dDay2 = list.get(7).getDDay();

		assertTrue(dDay1 < 7);
		assertTrue(dDay2 < 7);
		assertEquals("002", list.get(0).getGftStusCode());

	}
}
