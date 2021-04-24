package com.ncncn.service;

import com.ncncn.domain.CategoryVO;

import java.util.List;

public interface CategoryService {

	public List<CategoryVO> getCategoryList();

	// 카테고리 하나
	public CategoryVO getCate(String code);

}
