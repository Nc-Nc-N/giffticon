package com.ncncn.service;

import com.ncncn.domain.BankAccountVO;
import com.ncncn.domain.PntHistVO;
import com.ncncn.domain.pagination.MyPageCriteria;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ConService {

    public boolean accRegister(BankAccountVO bankAccountVO);

    public boolean accUpdate(BankAccountVO bankAccountVO);

    // 콘 충전 db에 저장
    public boolean insertConHist(PntHistVO pntHistVO);

    // user pnt update
    public boolean updateUserCon(@Param("userId") int userId,
                              @Param("balance") int balance);

    // 콘 내역 조회
    public List<PntHistVO> getConHistWithPaging(int userId, MyPageCriteria cri);

    public int getConTotal(int userId, MyPageCriteria cri);

    public boolean manualDealCmpl(int userId, int balance);
}
