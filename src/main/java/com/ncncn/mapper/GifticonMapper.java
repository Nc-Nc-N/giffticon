package com.ncncn.mapper;

import java.util.List;
import java.util.Map;

import com.ncncn.domain.GifticonVO;
import com.ncncn.domain.SaleRqustVO;
import com.ncncn.domain.pagination.SaleRqustCriteria;

public interface GifticonMapper {

	GifticonVO read(int id);

	List<SaleRqustVO> readAllRqustWithPaging(SaleRqustCriteria cri);

	Map<String, String> readRqustById(int id);

	int countAllRqust(SaleRqustCriteria cri);

	int updateStusCodeAndAprvDt(int id);

	int deleteById(int id);

}
