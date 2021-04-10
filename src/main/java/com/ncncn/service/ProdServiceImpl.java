package com.ncncn.service;

import com.ncncn.domain.*;
import com.ncncn.mapper.ProdMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j
@Service
@AllArgsConstructor
public class ProdServiceImpl implements ProdService{

	private ProdMapper mapper;

	@Override
	public CategoryVO getCate(String code) {

		return mapper.getCate(code);
	}

	@Override
	public List<BrandVO> getBrandList(String code) {

		return mapper.getBrandList(code);
	}

	@Override
	public List<GifticonDTO> getGiftiWithPaging(GiftiCriteria cri) {
		return mapper.getGiftiWithPaging(cri);
	}

	@Override
	public int getTotal(GiftiCriteria cri) {

		log.info("get total count");
		return mapper.getTotalCount(cri);
	}

}
