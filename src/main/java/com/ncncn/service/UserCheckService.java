package com.ncncn.service;

import com.ncncn.domain.*;
import com.ncncn.domain.pagination.UserCheckCriteria;

import java.util.List;

public interface UserCheckService {

    public List<UserVO> getUserList(UserCheckCriteria cri);

    public int getTotal(UserCheckCriteria cri);

    public UserDetailCheckDTO getUserDetail(int userId);

    public void updateMemo(UserMemoDTO memo);

    public void updateStatus(UserStatusDTO status);

}
