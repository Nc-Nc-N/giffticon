package com.ncncn.mapper;

import com.ncncn.domain.CategoryVO;

import java.util.List;

public interface CategoryMapper {

	public List<CategoryVO> getCategoryList();

	// 카테고리 하나
	public CategoryVO getCate(String code);

}
