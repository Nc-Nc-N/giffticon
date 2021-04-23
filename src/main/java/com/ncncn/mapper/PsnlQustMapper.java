package com.ncncn.mapper;

import java.util.List;

import com.ncncn.domain.CsPsnlQustVO;
import com.ncncn.domain.pagination.CsCriteria;
import org.apache.ibatis.annotations.Param;

public interface PsnlQustMapper {

	List<CsPsnlQustVO> getList();

	List<CsPsnlQustVO> getListWithPaging(CsCriteria cri);

	List<CsPsnlQustVO> getListPsnlQust(@Param("pageNum") int pageNum,
									   @Param("amount") int amount,
									   @Param("type") String type,
									   @Param("keyword") String keyword,
									   @Param("userId") int userId,
									   @Param("typeArr") String[] typeArr);

	void insert(CsPsnlQustVO notice);

	CsPsnlQustVO read(int id);

	int delete(int id);

	int update(CsPsnlQustVO notice);

	int updateUser(CsPsnlQustVO notice);

	int getTotalCount(CsCriteria cri);

	int getTotalPsnlQust(@Param("type") String type,
						 @Param("keyword") String keyword,
						 @Param("userId") int userId,
						 @Param("typeArr") String[] typeArr);

	int countHaveNoAns();
}
