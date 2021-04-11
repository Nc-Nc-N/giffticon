package com.ncncn.service;

import com.ncncn.mapper.GifticonMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;

@Log4j
@Service
@AllArgsConstructor
public class GifticonServiceImpl implements GifticonService{

    GifticonMapper mapper;

    @Override
    public int gftDealCmpl(int gftId){

        log.info("Gifticon Deal Complete Service.....");

        return mapper.gftDealCmpl(gftId);
    }
}
