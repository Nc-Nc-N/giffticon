package com.ncncn.service;

import java.util.List;

import com.ncncn.domain.AdminProdListVO;
import com.ncncn.domain.ProductVO;
import com.ncncn.domain.pagination.ProdCriteria;
import com.ncncn.domain.request.ProdRegisterDTO;
import org.apache.ibatis.annotations.Param;

public interface ProductService {

	List<ProductVO> getProductList(String brdName);

	ProductVO getProductObject(@Param("brdName") String brdName, @Param("prodName") String prodName);

	List<AdminProdListVO> getAllProduct(ProdCriteria cri);

	int countAllProd(ProdCriteria cri);

	ProductVO getProdByCode(String code);

	String register(ProdRegisterDTO product);

    List<ProductVO> getAllByBrdCode(String brdCode);

    ProductVO getByCode(String code);

    int modifyProduct(ProdRegisterDTO product);

	int modifyProductWithImagePath(ProdRegisterDTO product);

}
