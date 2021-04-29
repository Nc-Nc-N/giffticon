package com.ncncn.service;

import com.ncncn.domain.AdminProdListVO;
import com.ncncn.domain.ProductVO;
import com.ncncn.domain.pagination.ProdCriteria;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ProductService {

    List<ProductVO> getProductList(String brdName);

    ProductVO getProductObject(@Param("brdName") String brdName, @Param("prodName") String prodName);

    List<AdminProdListVO> getAllProduct(ProdCriteria cri);

    int countAllProd(ProdCriteria cri);
}
