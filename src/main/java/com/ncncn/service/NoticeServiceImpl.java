package com.ncncn.service;

import com.ncncn.domain.pagination.CriteriaCs;
import com.ncncn.domain.CsNoticeVO;
import com.ncncn.mapper.NoticeMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j
@Service
@AllArgsConstructor
public class NoticeServiceImpl implements NoticeService{

	private NoticeMapper mapper;


	@Override
	public void register(CsNoticeVO notice) {

		log.info("register....." + notice);

		mapper.insert(notice);	//insertSelectKey사용하는거 아니겠지?
	}


	@Override
	public CsNoticeVO get(int id) {

		log.info("get......" + id);
		return mapper.read(id);
	}

	@Override
	public boolean modify(CsNoticeVO notice) {

		log.info("modify...." + notice);
		return mapper.update(notice) == 1;
	}

	@Override
	public boolean remove(int id) {

		log.info("remove...." + id);
		return mapper.delete(id) == 1;
		//정상으로 삭제되면 1 값 반환하므로 true/false처리 가능
	}

//	@Override
//	public List<CsNoticeVO> getList() {
//
//		log.info("getList.....");
//		return mapper.getList();
//	}

	@Override
	public List<CsNoticeVO> getList(CriteriaCs cri) {

		log.info("getList with criteria: " + cri);
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(CriteriaCs cri) {

		log.info("get total count");
		return mapper.getTotalCount(cri);
	}
}
