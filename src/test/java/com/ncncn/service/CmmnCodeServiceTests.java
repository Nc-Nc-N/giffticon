package com.ncncn.service;

import com.ncncn.domain.CmmnCodeVO;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;
import java.util.Map;

import static org.junit.Assert.assertEquals;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/applicationContext.xml")
@Log4j
public class CmmnCodeServiceTests {

    @Autowired
    CmmnCodeService cmmnCodeService;

    @Test
    public void getBankListTest(){

        List<CmmnCodeVO> bnkList = cmmnCodeService.getBankList();

        assertEquals(bnkList.size(),5);
    }
}
