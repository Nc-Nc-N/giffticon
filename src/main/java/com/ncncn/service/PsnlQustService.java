package com.ncncn.service;

import com.ncncn.domain.CriteriaCs;
import com.ncncn.domain.CsPsnlQustVO;

import java.util.List;

public interface PsnlQustService {

	public void register(CsPsnlQustVO qna);

	public CsPsnlQustVO get(int id);

	public boolean modify(CsPsnlQustVO qna);

	public boolean modifyUser(CsPsnlQustVO qna);

	public boolean remove(int id);

	public List<CsPsnlQustVO> getList(CriteriaCs cri);

	public List<CsPsnlQustVO> getListPsnlQust(CriteriaCs cri, int userId);

	public int getTotal(CriteriaCs cri);

	public int getTotalPsnlQust(CriteriaCs cri,int userId);
}
