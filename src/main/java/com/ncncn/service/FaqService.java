package com.ncncn.service;

import com.ncncn.domain.pagination.CsCriteria;
import com.ncncn.domain.CsFaqVO;


import java.util.List;

public interface FaqService {

	public void register(CsFaqVO faq);

	public CsFaqVO get(int id);

	public boolean modify(CsFaqVO faq);

	public boolean remove(int id);

	public List<CsFaqVO> getList(CsCriteria cri);

	public List<CsFaqVO> getListUser(CsCriteria cri);

	public int getTotal(CsCriteria cri);

	public int getTotalUser(CsCriteria cri);

}
