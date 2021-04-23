package com.ncncn.service;

import com.ncncn.domain.*;
import com.ncncn.domain.pagination.UserCheckCriteria;

import java.util.List;

public interface UserCheckService {

    public List<UserVO> getUserList(UserCheckCriteria cri);

    public int getTotal(UserCheckCriteria cri);

    public UserDetailCheckVO getUserDetail(int userId);

    public void updateMemo(UserMemoVO memo);

    public void updateStatus(UserStatusVO status);

}
