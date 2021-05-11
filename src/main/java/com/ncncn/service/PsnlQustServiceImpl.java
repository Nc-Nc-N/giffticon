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
	public void register(CsPsnlQustVO qna) {	//1:1 문의 등록
		log.info("register....." + qna);

		mapper.insert(qna);
	}

	@Override
	public CsPsnlQustVO get(int id) {		//ajax에서 CsPsnlQustVO를 받아오기 위한 get(id)
		log.info("get......" + id);
		return mapper.read(id);
	}

	@Override
	public boolean modify(CsPsnlQustVO qna) {	// 관리자 1:1 문의 수정 및 답변.
		log.info("modify...." + qna);
		return mapper.update(qna) == 1;
	}

	@Override
	public boolean modifyFromUser(CsPsnlQustVO qna) {	//사용자 1:1 문의 수정.
		log.info("modify...." + qna);
		return mapper.updateFromUser(qna) == 1;
	}

	@Override
	public boolean remove(int id) {		// 1:1 문의 삭제.
		log.info("remove...." + id);
		return mapper.delete(id) == 1;
	}

	@Override
	public List<CsPsnlQustVO> getList(CsCriteria cri) {		//관리자 1:1문의 list 출력
		log.info("getList with criteria: " + cri);

		return mapper.getListWithPaging(cri);
	}

	@Override
	public List<CsPsnlQustVO> getListPsnlQust(CsCriteria cri, int userId) {		//사용자 1:1문의 list 출력
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
