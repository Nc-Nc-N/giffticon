package com.ncncn.service;

import com.ncncn.domain.BankAccountVO;

public interface PointService {

    public boolean accRegister(BankAccountVO bankAccountVO);

    public boolean accUpdate(BankAccountVO bankAccountVO);

}
