package com.ncncn.service;

import com.ncncn.domain.CmmnCodeVO;
import com.ncncn.domain.SoclInfoForSessionDTO;
import com.ncncn.mapper.SoclInfoMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Log4j
public class SoclInfoServiceImpl implements SoclInfoService {

    @Setter(onMethod_ = @Autowired)
    SoclInfoMapper soclInfoMapper;

    @Override
    public SoclInfoForSessionDTO getSoclType(int userId) {

        SoclInfoForSessionDTO soclInfoForSessionDTO = soclInfoMapper.getSocialInfo(userId);

        return soclInfoForSessionDTO;
    }

    @Override
    public Map<String,String> getSoclLoginCode(){

        List<CmmnCodeVO> typeList ;
        typeList = soclInfoMapper.getSocialType();

        Map<String,String> soclTypes = new HashMap<>();

        for(int i=0; i< typeList.size(); i++){

            soclTypes.put(typeList.get(i).getCodeName(),typeList.get(i).getCode());
        }

        return soclTypes;
    }
}
