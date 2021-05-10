package com.ncncn.mapper;

import java.util.List;

import com.ncncn.domain.AdminProdListVO;
import com.ncncn.domain.ProductVO;
import com.ncncn.domain.pagination.ProdCriteria;
import com.ncncn.domain.request.ProdRegisterDTO;
import org.apache.ibatis.annotations.Param;

public interface ProductMapper {

	List<ProductVO> getProductList(String brdName);

	ProductVO getProductObject(@Param("brdName") String brdName, @Param("prodName") String prodName);

	List<ProductVO> readAllByBrdCode(String brdCode);

	ProductVO readByCode(String code);

	int updateRegQuty(String prodCode);

	List<AdminProdListVO> readAllProductWithPaging(ProdCriteria cri);

	int countProductWithPaging(ProdCriteria cri);

	ProductVO getProdByCode(String code);

	int insert(ProdRegisterDTO product);

	int updateProduct(ProdRegisterDTO product);

	int updateProductWithImagePath(ProdRegisterDTO product);

}
