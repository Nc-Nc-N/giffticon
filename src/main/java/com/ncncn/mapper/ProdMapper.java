package com.ncncn.mapper;

import com.ncncn.domain.*;

import java.util.List;

public interface ProdMapper {

	// 카테고리 하나
	public CategoryVO getCate(String code);

	// 브랜드 목록
	public List<BrandVO> getBrandList(String code);

	// 기프티콘 목록(페이징 처리)
	public List<GifticonDTO> getGiftiWithPaging(GiftiCriteria cri);

	// 전체 데이터의 개수 처리
	public int getTotalCount(GiftiCriteria cri);

	// 기프티콘 목록
	public List<GifticonDTO> getGiftiList(String code);

	// 기프티콘 하나
	public GifticonDTO getGifti(String code);
}
