package com.ncncn.service;

import com.ncncn.domain.CriteriaCs;
import com.ncncn.domain.CsPsnlQustVO;
import com.ncncn.mapper.PsnlQustMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j
@Service
@AllArgsConstructor
public class PsnlQustServiceImpl implements PsnlQustService {

	private PsnlQustMapper mapper;


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
	public List<CsPsnlQustVO> getList(CriteriaCs cri) {

		log.info("getList with criteria: " + cri);

		return mapper.getListWithPaging(cri);
	}

	@Override
	public List<CsPsnlQustVO> getListPsnlQust(CriteriaCs cri, int userId) {

		log.info("getList Personal Question: " + cri);

		return mapper.getListPsnlQust(cri.getPageNum(), cri.getAmount(), cri.getType(), cri.getKeyword(), userId, cri.getTypeArr());
	}

	@Override
	public int getTotal(CriteriaCs cri) {

		log.info("get total count");
		return mapper.getTotalCount(cri);
	}

	@Override
	public int getTotalPsnlQust(CriteriaCs cri, int userId) {

		log.info("get total pursonal Question count");
		return mapper.getTotalPsnlQust(cri.getType(), cri.getKeyword(), userId, cri.getTypeArr());
	}
}
