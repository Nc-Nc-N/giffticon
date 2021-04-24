package com.ncncn.service;

import java.util.List;

import com.ncncn.domain.CsPsnlQustVO;
import com.ncncn.domain.pagination.CsCriteria;
import com.ncncn.mapper.PsnlQustMapper;
import lombok.extern.log4j.Log4j;

import org.springframework.stereotype.Service;

@Log4j
@Service
public class PsnlQustServiceImpl implements PsnlQustService {

	private PsnlQustMapper mapper;

	public PsnlQustServiceImpl(PsnlQustMapper mapper) {
		this.mapper = mapper;
	}

	@Override
	public void register(CsPsnlQustVO qna) {
		log.info("register....." + qna);

		mapper.insert(qna);
	}

	@Override
	public CsPsnlQustVO get(int id) {
		log.info("get......" + id);
		return mapper.read(id);
	}

	@Override
	public boolean modify(CsPsnlQustVO qna) {
		log.info("modify...." + qna);
		return mapper.update(qna) == 1;
	}

	@Override
	public boolean modifyUser(CsPsnlQustVO qna) {
		log.info("modify...." + qna);
		return mapper.updateUser(qna) == 1;
	}

	@Override
	public boolean remove(int id) {
		log.info("remove...." + id);
		return mapper.delete(id) == 1;
	}

	@Override
	public List<CsPsnlQustVO> getList(CsCriteria cri) {
		log.info("getList with criteria: " + cri);

		return mapper.getListWithPaging(cri);
	}

	@Override
	public List<CsPsnlQustVO> getListPsnlQust(CsCriteria cri, int userId) {
		log.info("getList Personal Question: " + cri);

		return mapper.getListPsnlQust(cri.getPageNum(), cri.getAmount(), cri.getType(), cri.getKeyword(), userId, cri.getTypeArr());
	}

	@Override
	public int getTotal(CsCriteria cri) {
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}

	@Override
	public int getTotalPsnlQust(CsCriteria cri, int userId) {
		log.info("get total pursonal Question count");
		return mapper.getTotalPsnlQust(cri.getType(), cri.getKeyword(), userId, cri.getTypeArr());
	}

	@Override
	public int countHaveNoAns() {
		return mapper.countHaveNoAns();
	}
}
