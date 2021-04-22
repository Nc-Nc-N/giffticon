package com.ncncn.mapper;

import com.ncncn.domain.pagination.CriteriaCs;
import com.ncncn.domain.CsNoticeVO;
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
public class NoticeMapperTests {

	@Setter(onMethod_ = @Autowired)
	private NoticeMapper mapper;

	@Test
	public void testGetList(){
		mapper.getList().forEach(notice -> log.info(notice));

	}

	@Test
	public void testInsert(){

		CsNoticeVO notice = new CsNoticeVO();
		notice.setUserId(4);
		notice.setTitle("새로운 공지사항");
		notice.setCntnt("새로운 공지사항 내용");
		notice.setCsCateCode("3");
		notice.setIsFixed('1');


		mapper.insert(notice);

		log.info(notice);
	}

	@Test
	public void testRead(){

		CsNoticeVO notice = mapper.read(1);

		log.info(notice);
	}

	@Test
	public void testDelete(){

		log.info("Delete Count: " + mapper.delete(5));
	}

	@Test
	public void testUpdate(){
		CsNoticeVO notice = new CsNoticeVO();

		notice.setId(1);
		notice.setTitle("수정된 공지사항");
		notice.setCntnt("수정된 공지사항 내용");
		notice.setIsFixed('0');

		int count = mapper.update(notice);
		log.info("UPDATE COUNT: " + count);
	}

	@Test
	public void testPaging(){

		CriteriaCs cri = new CriteriaCs();

		cri.setPageNum(3);
		cri.setAmount(10);

		List<CsNoticeVO> list = mapper.getListWithPaging(cri);

		list.forEach(notice -> log.info(notice.getId()));
	}

}
