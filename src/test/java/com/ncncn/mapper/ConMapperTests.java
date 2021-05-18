package com.ncncn.mapper;

import com.ncncn.domain.BankAccountVO;
import com.ncncn.domain.PntHistVO;
import com.ncncn.domain.pagination.MyPageCriteria;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.assertEquals;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/applicationContext.xml")
@Log4j
public class ConMapperTests {

    @Setter(onMethod_ = @Autowired)
    ConMapper conMapper;

    @Test
    public void accRegister() {

        BankAccountVO bankAccountVO = new BankAccountVO();
        bankAccountVO.setAcc("0000111000232");
        bankAccountVO.setUserId(5);
        bankAccountVO.setBnkCode("003");
        bankAccountVO.setHolder("다람쥐");
        bankAccountVO.setIsAuthed('1');
        bankAccountVO.setAccStus("001");

        conMapper.accRegister(bankAccountVO);

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

        int updated = conMapper.accUpdate(bankAccountVO);

        assertEquals(1, updated);

    }

    @Test
    public void testAddCon(){

        // 충전(입금)
        PntHistVO pntHistVO = new PntHistVO();
        pntHistVO.setUserId(156);
        pntHistVO.setChgQuty(5000);
        pntHistVO.setPntHistCode("001");

        conMapper.insertConHist(pntHistVO);
        int balance = pntHistVO.getBalance();

        conMapper.updateUserCon(156, balance);

        // 구매
        PntHistVO pnt = new PntHistVO();
        pnt.setUserId(156);
        pnt.setChgQuty(-5000);
        pnt.setPntHistCode("003");

        conMapper.insertConHist(pnt);
        int bal = pnt.getBalance();

        conMapper.updateUserCon(156, bal);

    }

    @Test
    public void testGetConHistWithPaging(){

        int userId = 156;
        MyPageCriteria cri = new MyPageCriteria();


        List<PntHistVO> con = conMapper.getConHistWithPaging(userId, cri.getAmount(), cri.getPageNum(),
                cri.getDateFrom(), cri.getDateTo(), cri.getType(), cri.getTypeArr());
        assertEquals(4, con.size());

    }

    @Test
    public void testGetConTotal(){

        int userId = 156;
        MyPageCriteria cri = new MyPageCriteria();
        cri.setAmount(100000);

        List<PntHistVO> con = conMapper.getConHistWithPaging(userId, cri.getAmount(), cri.getPageNum(),
                cri.getDateFrom(), cri.getDateTo(), cri.getType(), cri.getTypeArr());
        int cnt = conMapper.getConTotal(userId, cri.getDateFrom(), cri.getDateTo(), cri.getType(), cri.getTypeArr());

        assertEquals(con.size(), cnt);

    }

}
