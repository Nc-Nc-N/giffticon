package com.ncncn.mapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.Assert.assertEquals;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/applicationContext.xml")
@Log4j
public class CmmnCodeMapperTests {

    @Setter(onMethod_ = @Autowired)
    private CmmnCodeMapper cmmnCodeMapper;

    @Test
    public void getBankListTests(){

        List<Map<String, String>> bnk = cmmnCodeMapper.getBankList();

        assertEquals(bnk.size(),5);

    }
}
