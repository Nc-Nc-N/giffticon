package com.ncncn.mapper;

import com.ncncn.domain.BankAccountVO;

public interface PointMapper {

    public void accRegister(BankAccountVO bankAccountVO);

    public int accUpdate(BankAccountVO bankAccountVO);
}
