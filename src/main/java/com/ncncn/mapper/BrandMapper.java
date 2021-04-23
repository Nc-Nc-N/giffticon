package com.ncncn.mapper;

import com.ncncn.domain.BrandVO;

import java.util.List;

public interface BrandMapper {

	public List<BrandVO> getBrandList(String catName);

	// 브랜드 목록
	public List<BrandVO> getBrdList(String code);

}
