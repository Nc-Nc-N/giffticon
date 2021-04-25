package com.ncncn.service;

import com.ncncn.domain.BrandVO;
import com.ncncn.mapper.BrandMapper;
import lombok.AllArgsConstructor;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class BrandServiceImpl implements BrandService{

	@Setter(onMethod_ = @Autowired)
	private BrandMapper mapper;

	@Override
	public List<BrandVO> getBrandList(String catName){
		return mapper.getBrandList(catName);
	}

	@Override
	public List<BrandVO> getBrdList(String code) {
		return mapper.getBrdList(code);
	}
}
