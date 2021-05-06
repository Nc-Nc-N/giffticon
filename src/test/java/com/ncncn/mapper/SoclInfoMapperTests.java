package com.ncncn.mapper;

import com.ncncn.domain.CmmnCodeVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/applicationContext.xml")
@Log4j
public class SoclInfoMapperTests {

    @Setter(onMethod_ = @Autowired)
    SoclInfoMapper soclInfoMapper;

    @Test
    public void getSocialTypeTest(){

      List<CmmnCodeVO> soclType ;
      soclType = soclInfoMapper.getSocialType();

      Map<String,String> soclMap = new HashMap<>();

      for(int i=0; i< soclType.size(); i++){

          soclMap.put(soclType.get(i).getCodeName(),soclType.get(i).getCode());

      }
      log.info("soclType : " + soclMap);
    }
}
