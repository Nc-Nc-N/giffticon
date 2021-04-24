package com.ncncn.mapper;


import com.ncncn.domain.pagination.CsCriteria;
import com.ncncn.domain.CsFaqVO;


import java.util.List;

public interface FaqMapper {

	public List<CsFaqVO> getList();

	public List<CsFaqVO> getListWithPaging(CsCriteria cri);

	public List<CsFaqVO> getListWithPagingUser(CsCriteria cri);

	public void insert(CsFaqVO notice);

	public CsFaqVO read(int id);

	public int delete(int id);

	public int update(CsFaqVO notice);

	public int getTotalCount(CsCriteria cri);

	public int getTotalCountUser(CsCriteria cri);

}
