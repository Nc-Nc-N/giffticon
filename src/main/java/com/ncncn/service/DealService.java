package com.ncncn.service;

import com.ncncn.domain.BrandVO;
import com.ncncn.domain.CategoryVO;
import com.ncncn.domain.ProductVO;

import java.util.List;

public interface DealService {

    public List<CategoryVO> getCategoryList();

    public List<BrandVO> getBrandList();

    public List<ProductVO> getProductList();

}
