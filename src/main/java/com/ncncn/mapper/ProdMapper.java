package com.ncncn.mapper;

import com.ncncn.domain.*;

import java.util.List;

public interface ProdMapper {

	// 카테고리 하나
	public CategoryVO getCate(String code);

	// 브랜드 목록
	public List<BrandVO> getBrandList(String code);

	// 기프티콘 목록(페이징 처리)
	public List<ProdListVO> getGiftiWithPaging(GiftiCriteria cri);

	// 전체 데이터의 개수 처리
	public int getTotalCount(GiftiCriteria cri);

	// 기프티콘 목록
	public List<ProdListVO> getGiftiList(String code);

	// 기프티콘 하나
	public ProdListVO getGifti(String code);

	// 인기상품 목록
	public List<ProdListVO> getBestGifti();

	// 마감임박 상품 목록
	public List<ProdListVO> getDeadlineGifti();
}
