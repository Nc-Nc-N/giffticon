package com.ncncn.service;

import com.ncncn.mapper.CmmnCodeMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@Log4j
public class CmmnCodeServiceImpl implements CmmnCodeService{

    @Setter(onMethod_ = @Autowired)
    CmmnCodeMapper cmmnCodeMapper;

    @Override
    public List<Map<String,String>> getBankList(){

        List<Map<String, String>> bnkList = cmmnCodeMapper.getBankList();

        return bnkList;
    }
}
