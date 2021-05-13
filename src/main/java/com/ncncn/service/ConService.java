package com.ncncn.service;

import com.ncncn.domain.BankAccountVO;
import com.ncncn.domain.PntHistVO;
import org.apache.ibatis.annotations.Param;

public interface ConService {

    public boolean accRegister(BankAccountVO bankAccountVO);

    public boolean accUpdate(BankAccountVO bankAccountVO);

    // 콘 충전 db에 저장
    public boolean insertConHist(PntHistVO pntHistVO);

    // user pnt update
    public boolean updateUserCon(@Param("userId") int userId,
                              @Param("balance") int balance);

}
