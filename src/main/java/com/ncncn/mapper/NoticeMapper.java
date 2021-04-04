package com.ncncn.mapper;


import com.ncncn.domain.CsNoticeVO;

import java.util.List;

public interface NoticeMapper {

	public List<CsNoticeVO> getList();

	public void insert(CsNoticeVO notice);

	public  void insertSelectKey(CsNoticeVO notice);
}
