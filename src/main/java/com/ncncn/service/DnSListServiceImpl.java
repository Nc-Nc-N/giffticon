package com.ncncn.service;

import com.ncncn.domain.GifticonVO;
import com.ncncn.domain.MyDealsDTO;
import com.ncncn.mapper.DnSListMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j
@Service
@AllArgsConstructor
public class DnSListServiceImpl implements DnSListService{

    private DnSListMapper mapper;

//    @Override
//    public List<MyDealsDTO> getDeals(String email){
//        log.info("DnS Service Impl......");
//
//        return mapper.getDeals(email);
//    }

    @Override
    public List<MyDealsDTO> getGftDetail(int gftId){

        log.info("Get Detail of gft Id: " + gftId);

        return mapper.getGftDetail(gftId);
    }

    @Override
    public List<MyDealsDTO> getDealsWithPaging(String email, int amount, int pageNum){
        log.info("Service of Get Deals with Paging....");

        return mapper.getDealsWithPaging(email, amount, pageNum);
    }

    @Override
    public int countDealList(String email){
        log.info("Count " + email + "'s deal list....");

        return mapper.countDealList(email);
    }
}
