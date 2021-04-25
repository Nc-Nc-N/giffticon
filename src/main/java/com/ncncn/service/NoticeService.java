package com.ncncn.service;

import com.ncncn.domain.pagination.CsCriteria;
import com.ncncn.domain.CsNoticeVO;

import java.util.List;

public interface NoticeService {

	public void register(CsNoticeVO notice);

	public CsNoticeVO get(int id);

	public boolean modify(CsNoticeVO notice);

	public boolean remove(int id);

	public List<CsNoticeVO> getList(CsCriteria cri);

	public int getTotal(CsCriteria cri);
}
