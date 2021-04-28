package com.ncncn.service;

import com.ncncn.domain.BankAccountVO;
import com.ncncn.domain.UserVO;
import com.ncncn.mapper.PointMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@Log4j
@AllArgsConstructor
public class PointServiceImpl implements PointService {

    PointMapper pointMapper;

    @Override
    public boolean accRegister(BankAccountVO bankAccountVO) {

        try {
            pointMapper.accRegister(bankAccountVO);
            log.info("계좌 등록 성공");
            return true;
        } catch (Exception e) {
            log.info("계좌등록에 실패했습니다.");
            return false;
        }

    }

    @Override
    public boolean accUpdate(BankAccountVO bankAccountVO) {


        int updated = pointMapper.accUpdate(bankAccountVO);

        if (updated == 1) {
            log.info("계좌 수정 성공");
            return true;
        } else {
            log.info("계좌 수정 오류");
            return false;
        }
    }
}
