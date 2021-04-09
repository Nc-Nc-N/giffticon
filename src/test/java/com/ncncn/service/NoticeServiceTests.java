package com.ncncn.service;



import com.ncncn.domain.CriteriaCs;
import com.ncncn.domain.CsNoticeVO;
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
public class NoticeServiceTests {

	@Setter(onMethod_ = {@Autowired})
	private NoticeService service;

	@Test
	public void testExist(){

		log.info(service);
		assertNotNull(service);
	}

	@Test
	public void testRegister(){

		CsNoticeVO notice = new CsNoticeVO();
		notice.setUserId(4);
		notice.setTitle("서비스를 통한 새로운 공지사항");
		notice.setCntnt("서비스를 통한 새로운 공지사항 내용");
		notice.setCsCateCode("3");
		notice.setIsFixed('0');

		service.register(notice);

//		log.info("생성된 게시물의 번호: " + notice.getId()); --> ID번호는 가져오지 못함.
	}



	@Test
	public void testGetList(){
//		service.getList().forEach(notice -> log.info(notice));
		service.getList(new CriteriaCs(2,10)).forEach(notice -> log.info(notice));
	}

	@Test
	public void testGet(){

		log.info(service.get(1));
	}

	@Test
	public void testDelete(){

		log.info("REMOVE RESULT: " + service.remove(6));
	}

	@Test
	public void testUpdate(){

		CsNoticeVO notice = service.get(1);

		if (notice == null){
			return;
		}

		notice.setTitle("서비스로 제목 수정합니다");
		log.info("MODIFY RESULT: " + service.modify(notice));
	}


}
