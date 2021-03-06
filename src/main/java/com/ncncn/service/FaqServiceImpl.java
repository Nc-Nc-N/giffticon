package com.ncncn.service;

import com.ncncn.domain.pagination.CsCriteria;
import com.ncncn.domain.CsFaqVO;
import com.ncncn.mapper.FaqMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;
import java.util.List;

@Log4j
@Service
@AllArgsConstructor
public class FaqServiceImpl implements FaqService{

	private FaqMapper mapper;


	@Override
	public void register(CsFaqVO faq) {

		log.info("register....." + faq);

		mapper.insert(faq);
	}


	@Override
	public CsFaqVO get(int id) {

		log.info("get......" + id);
		return mapper.read(id);
	}

	@Override
	public boolean modify(CsFaqVO faq) {

		log.info("modify...." + faq);
		return mapper.update(faq) == 1;
	}

	@Override
	public boolean remove(int id) {

		log.info("remove...." + id);
		return mapper.delete(id) == 1;

	}

	@Override
	public List<CsFaqVO> getList(CsCriteria cri) {

		log.info("getList with criteria: " + cri);

		return mapper.getListWithPaging(cri);
	}

	@Override
	public List<CsFaqVO> getListUser(CsCriteria cri) {

		log.info("getListUser with criteria: " + cri);

		return mapper.getListWithPagingUser(cri);
	}


	@Override
	public int getTotal(CsCriteria cri) {

		log.info("get total count");
		return mapper.getTotalCount(cri);
	}

	@Override
	public int getTotalUser(CsCriteria cri) {

		log.info("get total count user");
		return mapper.getTotalCountUser(cri);
	}
}
