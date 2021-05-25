package com.ncncn.service;

import com.ncncn.domain.BankAccountVO;
import com.ncncn.domain.PntHistVO;
import com.ncncn.domain.pagination.MyPageCriteria;
import com.ncncn.mapper.ConMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Log4j
@AllArgsConstructor
public class ConServiceImpl implements ConService {

    ConMapper conMapper;

    @Override
    public boolean accRegister(BankAccountVO bankAccountVO) {

        try {
            conMapper.accRegister(bankAccountVO);
            log.info("계좌 등록 성공");
            return true;
        } catch (Exception e) {
            log.info("계좌등록에 실패했습니다.");
            return false;
        }

    }

    @Override
    public boolean accUpdate(BankAccountVO bankAccountVO) {


        int updated = conMapper.accUpdate(bankAccountVO);

        if (updated == 1) {
            log.info("계좌 수정 성공");
            return true;
        } else {
            log.info("계좌 수정 오류");
            return false;
        }
    }

    @Override
    public boolean insertConHist(PntHistVO pntHistVO) {

        try{
            conMapper.insertConHist(pntHistVO);
            log.info("콘 충전 내역 저장 성공");
            return true;

        } catch (Exception e){
            log.info("콘 충전 내역 저장 실패");
            return false;
        }
    }

    @Override
    public boolean updateUserCon(int userId, int balance) {

        try{
            conMapper.updateUserCon(userId, balance);
            log.info("사용자 보유 con 수정 성공");
            return true;

        } catch (Exception e){
            log.info("사용자 보유 con 수정 실패");
            return false;
        }
    }

    @Override
    public List<PntHistVO> getConHistWithPaging(int userId, MyPageCriteria cri){
        return conMapper.getConHistWithPaging(userId, cri.getAmount(), cri.getPageNum(),
                cri.getDateFrom(), cri.getDateTo(), cri.getType(), cri.getTypeArr());
    }

    @Override
    public int getConTotal(int userId, MyPageCriteria cri) {
        return conMapper.getConTotal(userId,cri.getDateFrom(), cri.getDateTo(), cri.getType(), cri.getTypeArr());
    }

    @Override
    public boolean manualDealCmpl(int userId, int balance) {

        try{
            conMapper.manualDealCmpl(userId, (int)(balance/100*90));
            log.info("사용자 보유 con 수정 성공");
            return true;

        } catch (Exception e){
            log.info("사용자 보유 con 수정 실패");
            return false;
        }
    }

}
