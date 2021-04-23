package com.ncncn.mapper;


import com.ncncn.domain.pagination.CriteriaCs;
import com.ncncn.domain.CsFaqVO;


import java.util.List;

public interface FaqMapper {

	public List<CsFaqVO> getList();

	public List<CsFaqVO> getListWithPaging(CriteriaCs cri);

	public List<CsFaqVO> getListWithPagingUser(CriteriaCs cri);

	public void insert(CsFaqVO notice);

	public CsFaqVO read(int id);

	public int delete(int id);

	public int update(CsFaqVO notice);

	public int getTotalCount(CriteriaCs cri);

	public int getTotalCountUser(CriteriaCs cri);

}
