package com.ncncn.service;

import com.ncncn.domain.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ProdService {

	// 카테고리 하나
	public CategoryVO getCate(String code);

	// 브랜드 목록
	public List<BrandVO> getBrandList(String code);

	// 상품 조회
	public List<GifticonDTO> getGifti(String code, String orderby);

}
