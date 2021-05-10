package com.ncncn.mapper;

import com.ncncn.domain.BankAccountVO;
import com.ncncn.domain.PntHistVO;
import org.apache.ibatis.annotations.Param;

public interface ConMapper {

    public void accRegister(BankAccountVO bankAccountVO);

    public int accUpdate(BankAccountVO bankAccountVO);

    // 콘 충전 db에 저장
    public boolean insertConHist(PntHistVO pntHistVO);

    // user pnt update
    public boolean updateUserCon(@Param("userId") int userId,
                              @Param("balance") int balance);

    // 콘 사용 db에 저장
    public boolean payCon(PntHistVO pntHistVO);

}
