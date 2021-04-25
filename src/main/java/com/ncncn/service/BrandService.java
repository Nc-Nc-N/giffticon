package com.ncncn.service;

import com.ncncn.domain.BrandVO;

import java.util.List;

public interface BrandService {

	public List<BrandVO> getBrandList(String catName);

	// 브랜드 목록
	public List<BrandVO> getBrdList(String code);

}
