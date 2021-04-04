package com.ncncn.service;

import com.ncncn.domain.BrandVO;
import com.ncncn.domain.CategoryVO;
import com.ncncn.domain.ProductVO;
import com.ncncn.mapper.DealMapper;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j
@Service
@AllArgsConstructor
public class DealServiceImpl implements DealService {

    @Setter(onMethod_ = @Autowired)
    private DealMapper mapper;

    @Override
    public List<CategoryVO> getCategoryList(){
        log.info("getList...........");
        return mapper.getCategoryList();
    }

    @Override
    public List<BrandVO> getBrandList(){
        log.info("getList...........");
        return mapper.getBrandList();
    }

    @Override
    public List<ProductVO> getProductList(){
        log.info("getList...........");
        return mapper.getProductList();
    }

}
