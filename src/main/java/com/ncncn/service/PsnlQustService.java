package com.ncncn.service;

import java.util.List;

import com.ncncn.domain.CsPsnlQustVO;
import com.ncncn.domain.pagination.CriteriaCs;

public interface PsnlQustService {

	void register(CsPsnlQustVO qna);

	CsPsnlQustVO get(int id);

	boolean modify(CsPsnlQustVO qna);

	boolean modifyUser(CsPsnlQustVO qna);

	boolean remove(int id);

	List<CsPsnlQustVO> getList(CriteriaCs cri);

	List<CsPsnlQustVO> getListPsnlQust(CriteriaCs cri, int userId);

	int getTotal(CriteriaCs cri);

	int getTotalPsnlQust(CriteriaCs cri, int userId);

	int countHaveNoAns();
}
