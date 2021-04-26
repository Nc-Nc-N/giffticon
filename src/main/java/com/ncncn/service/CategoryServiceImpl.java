package com.ncncn.service;

import com.ncncn.domain.CategoryVO;
import com.ncncn.mapper.CategoryMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class CategoryServiceImpl implements CategoryService{

	private CategoryMapper mapper;

	@Override
	public List<CategoryVO> getCategoryList() {
		return mapper.getCategoryList();
	}

	@Override
	public CategoryVO getCate(String code) {

		return mapper.getCate(code);
	}
}
