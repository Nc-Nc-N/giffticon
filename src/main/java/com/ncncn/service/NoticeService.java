package com.ncncn.service;

import com.ncncn.domain.CriteriaCs;
import com.ncncn.domain.CsNoticeVO;

import java.util.List;

public interface NoticeService {

	public void register(CsNoticeVO notice);

	public CsNoticeVO get(int id);

	public boolean modify(CsNoticeVO notice);

	public boolean remove(int id);

//	public List<CsNoticeVO> getList();

	public List<CsNoticeVO> getList(CriteriaCs cri);

	public int getTotal(CriteriaCs cri);
}
