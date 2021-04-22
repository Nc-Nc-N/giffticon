package com.ncncn.service;

import com.ncncn.domain.CriteriaCs;
import com.ncncn.domain.CsFaqVO;


import java.util.List;

public interface FaqService {

	public void register(CsFaqVO faq);

	public CsFaqVO get(int id);

	public boolean modify(CsFaqVO faq);

	public boolean remove(int id);

	public List<CsFaqVO> getList(CriteriaCs cri);

	public List<CsFaqVO> getListUser(CriteriaCs cri);

	public int getTotal(CriteriaCs cri);

	public int getTotalUser(CriteriaCs cri);

}
