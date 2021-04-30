package com.ncncn.service;

import com.ncncn.domain.ProductVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ProductService {

    public List<ProductVO> getProductList(String brdName);

    public ProductVO getProductObject(@Param("brdName") String brdName, @Param("prodName") String prodName);

    List<ProductVO> getAllByBrdCode(String brdCode);

    ProductVO getByCode(String code);
}
