package com.ncncn.service;

import com.ncncn.domain.CriteriaCH;
import com.ncncn.domain.UserVO;

import java.util.List;

public interface UserCheckService {

//    public List<UserVO> getUserList();
    public List<UserVO> getUserList(CriteriaCH cri);

    public int getTotal(CriteriaCH cri);
}
