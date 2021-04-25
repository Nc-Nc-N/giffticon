package com.ncncn.mapper;

import com.ncncn.domain.ProductVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ProductMapper {

    public List<ProductVO> getProductList(String brdName);

    public ProductVO getProductObject(@Param("brdName") String brdName, @Param("prodName") String prodName);

}
