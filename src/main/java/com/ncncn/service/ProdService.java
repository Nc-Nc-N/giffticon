package com.ncncn.service;

import com.ncncn.domain.*;

import java.util.List;

public interface ProdService {

	// 카테고리 하나
	public CategoryVO getCate(String code);

	// 브랜드 목록
	public List<BrandVO> getBrandList(String code);

	// 상품 조회
	public List<GifticonDTO> getGiftiWithPaging(GiftiCriteria cri);

	// 전체 데이터의 개수 처리
	public int getTotal(GiftiCriteria cri);

}
