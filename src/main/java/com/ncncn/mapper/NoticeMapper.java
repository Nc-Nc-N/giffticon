package com.ncncn.mapper;


import com.ncncn.domain.pagination.CsCriteria;
import com.ncncn.domain.CsNoticeVO;

import java.util.List;

public interface NoticeMapper {

	public List<CsNoticeVO> getList();

	public List<CsNoticeVO> getListWithPaging(CsCriteria cri);

	public void insert(CsNoticeVO notice);

	public CsNoticeVO read(int id);

	public int delete(int id);

	public int update(CsNoticeVO notice);

	public int getTotalCount(CsCriteria cri);

}
