package com.ncncn.service;

import com.ncncn.domain.BrandVO;
import com.ncncn.domain.CategoryVO;
import com.ncncn.domain.GifticonVO;
import com.ncncn.domain.ProductVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface DealService {

    public List<CategoryVO> getCategoryList();

    public List<BrandVO> getBrandList(String catName);

    public List<ProductVO> getProductList(String brdName);

    public ProductVO getProductObject(@Param("brdName") String brdName, @Param("prodName") String prodName);

    public void registerGifticon(GifticonVO gifticon);

}
