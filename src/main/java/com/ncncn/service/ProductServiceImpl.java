package com.ncncn.service;

import com.ncncn.domain.AdminProdListVO;
import com.ncncn.domain.ProductVO;
import com.ncncn.domain.pagination.ProdCriteria;
import com.ncncn.mapper.ProductMapper;
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
public class ProductServiceImpl implements ProductService {

    @Setter(onMethod_ = @Autowired)
    private ProductMapper mapper;

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
    public List<AdminProdListVO> getAllProduct(ProdCriteria cri) {
        return mapper.readAllProductWithPaging(cri);
    }

    @Override
    public int countAllProd(ProdCriteria cri) {
        return mapper.countProductWithPaging(cri);
    }

}
