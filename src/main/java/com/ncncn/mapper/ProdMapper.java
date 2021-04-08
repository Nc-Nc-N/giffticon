package com.ncncn.mapper;

import com.ncncn.domain.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ProdMapper {

	// 카테고리 하나
	public CategoryVO getCate(String code);

	// 브랜드 목록
	public List<BrandVO> getBrandList(String code);

	// 기프티콘 조회
	public List<GifticonDTO> getGifti(@Param("code")String code, @Param("orderby")String orderby);

	public List<GifticonDTO> getGiftiWithPaging(Criteria cri);

}
