package com.ncncn.service;

import com.ncncn.domain.BrandVO;
import com.ncncn.domain.CategoryVO;
import com.ncncn.domain.GifticonVO;
import com.ncncn.domain.ProductVO;
import com.ncncn.mapper.DealMapper;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Log4j
@Service
@AllArgsConstructor
public class DealServiceImpl implements DealService {

    @Setter(onMethod_ = @Autowired)
    private DealMapper mapper;

    @Override
    public List<CategoryVO> getCategoryList(){
        log.info("get category list...........");
        return mapper.getCategoryList();
    }

    @Override
    public List<BrandVO> getBrandList(String catName){
        log.info("get brand list...........");
        return mapper.getBrandList(catName);
    }

    @Override
    public List<ProductVO> getProductList(String brdName){
        log.info("get product list...........");
        return mapper.getProductList(brdName);
    }

    @Override
    public ProductVO getProductObject(@RequestParam("brdName") String brdName, @RequestParam("prodName") String prodName) {
        log.info("get product object.............");
        return mapper.getProductObject(brdName, prodName);
    }

    @Override
    public void registerGifticon(GifticonVO gifticon) {
        log.info("registerGifticon..................");
        mapper.registerGifticon(gifticon);
    }

}
