package com.ncncn.mapper;

import com.ncncn.domain.AdminProdListVO;
import com.ncncn.domain.ProductVO;
import com.ncncn.domain.pagination.ProdCriteria;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ProductMapper {

    List<ProductVO> getProductList(String brdName);

    ProductVO getProductObject(@Param("brdName") String brdName, @Param("prodName") String prodName);

    List<AdminProdListVO> readAllProductWithPaging(ProdCriteria cri);

    int countProductWithPaging(ProdCriteria cri);
}
