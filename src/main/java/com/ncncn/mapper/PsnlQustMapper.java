package com.ncncn.mapper;

import com.ncncn.domain.CriteriaCs;
import com.ncncn.domain.CsPsnlQustVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PsnlQustMapper {

	public List<CsPsnlQustVO> getList();

	public List<CsPsnlQustVO> getListWithPaging(CriteriaCs cri);

	public List<CsPsnlQustVO> getListPsnlQust(@Param("pageNum") int pageNum,
											  @Param("amount") int amount,
											  @Param("type") String type,
											  @Param("keyword") String keyword,
											  @Param("userId") int userId,
											  @Param("typeArr")String[] typeArr);

	public void insert(CsPsnlQustVO notice);

	public CsPsnlQustVO read(int id);

	public int delete(int id);

	public int update(CsPsnlQustVO notice);

	public int getTotalCount(CriteriaCs cri);

	public int getTotalPsnlQust( @Param("type") String type,
								 @Param("keyword") String keyword,
								 @Param("userId") int userId,
								 @Param("typeArr")String[] typeArr);

}
