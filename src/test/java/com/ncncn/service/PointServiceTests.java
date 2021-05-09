package com.ncncn.service;

import com.ncncn.domain.BankAccountVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.assertTrue;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/applicationContext.xml")
@Log4j

public class PointServiceTests {

    @Setter(onMethod_ = @Autowired)
	ConService pointService;

    @Test
    public void accRegisterTest() {

        BankAccountVO bankAccountVO = new BankAccountVO();
        bankAccountVO.setAcc("333333333");
        bankAccountVO.setUserId(1);
        bankAccountVO.setBnkCode("002");
        bankAccountVO.setHolder("다람쥐");
        bankAccountVO.setIsAuthed('1');
        bankAccountVO.setAccStus("001");

        boolean registerd = pointService.accRegister(bankAccountVO);

        assertTrue(registerd);
    }

    @Test
    public void accUpdateTest() {

        BankAccountVO bankAccountVO = new BankAccountVO();
        bankAccountVO.setAcc("0000001111110000000");
        bankAccountVO.setUserId(187);
        bankAccountVO.setBnkCode("009");
        bankAccountVO.setHolder("위헤이줘이");
        bankAccountVO.setIsAuthed('1');
        bankAccountVO.setAccStus("001");

        boolean updated = pointService.accUpdate(bankAccountVO);

        assertTrue(updated);
    }
}
