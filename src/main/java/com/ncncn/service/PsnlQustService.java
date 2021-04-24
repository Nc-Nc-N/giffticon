package com.ncncn.service;

import java.util.List;

import com.ncncn.domain.CsPsnlQustVO;
import com.ncncn.domain.pagination.CsCriteria;

public interface PsnlQustService {

	void register(CsPsnlQustVO qna);

	CsPsnlQustVO get(int id);

	boolean modify(CsPsnlQustVO qna);

	boolean modifyUser(CsPsnlQustVO qna);

	boolean remove(int id);

	List<CsPsnlQustVO> getList(CsCriteria cri);

	List<CsPsnlQustVO> getListPsnlQust(CsCriteria cri, int userId);

	int getTotal(CsCriteria cri);

	int getTotalPsnlQust(CsCriteria cri, int userId);

	int countHaveNoAns();
}
