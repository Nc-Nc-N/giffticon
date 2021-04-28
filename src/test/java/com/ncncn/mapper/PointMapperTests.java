package com.ncncn.mapper;

import com.ncncn.domain.BankAccountVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.assertEquals;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/applicationContext.xml")
@Log4j
public class PointMapperTests {

    @Setter(onMethod_ = @Autowired)
    PointMapper pointMapper;

    @Test
    public void accRegister() {

        BankAccountVO bankAccountVO = new BankAccountVO();
        bankAccountVO.setAcc("0000111000232");
        bankAccountVO.setUserId(5);
        bankAccountVO.setBnkCode("003");
        bankAccountVO.setHolder("다람쥐");
        bankAccountVO.setIsAuthed('1');
        bankAccountVO.setAccStus("001");

        pointMapper.accRegister(bankAccountVO);

    }

    @Test
    public void accUpdate() {

        BankAccountVO bankAccountVO = new BankAccountVO();
        bankAccountVO.setAcc("123456789098");
        bankAccountVO.setUserId(187);
        bankAccountVO.setBnkCode("006");
        bankAccountVO.setHolder("위허이줘이");
        bankAccountVO.setIsAuthed('5');
        bankAccountVO.setAccStus("001");

        int updated = pointMapper.accUpdate(bankAccountVO);

        assertEquals(updated, 1);

    }

}
