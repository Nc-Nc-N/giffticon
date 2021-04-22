package com.ncncn.service;

import com.ncncn.domain.*;
import com.ncncn.domain.pagination.CriteriaCH;

import java.util.List;

public interface UserCheckService {

    public List<UserVO> getUserList(CriteriaCH cri);

    public int getTotal(CriteriaCH cri);

    public UserDetailCheckDTO getUserDetail(int userId);

    public void updateMemo(UserMemoDTO memo);

    public void updateStatus(UserStatusDTO status);

}
