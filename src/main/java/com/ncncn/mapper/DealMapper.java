package com.ncncn.mapper;

import com.ncncn.domain.BrandVO;
import com.ncncn.domain.CategoryVO;
import com.ncncn.domain.ProductVO;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface DealMapper {

//    @Select("select * from giffticon.category")
    public List<CategoryVO> getCategoryList();

    public List<BrandVO> getBrandList();

    public List<ProductVO> getProductList();
}
