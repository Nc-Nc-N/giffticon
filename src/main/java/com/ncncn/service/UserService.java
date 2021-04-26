package com.ncncn.service;

import com.ncncn.domain.UserDetailCheckVO;
import com.ncncn.domain.UserMemoVO;
import com.ncncn.domain.UserStatusVO;
import com.ncncn.domain.UserVO;
import com.ncncn.domain.pagination.UserCheckCriteria;

import java.util.List;

public interface UserService {

    UserVO readbyId(int userId);

	int countRecentlyRegister();


    List<UserVO> getUserList(UserCheckCriteria cri);

    List<UserVO> getUserListQuit(UserCheckCriteria cri);

    int getTotal(UserCheckCriteria cri);

    int getTotalQuit(UserCheckCriteria cri);

    UserDetailCheckVO getUserDetail(int userId);

    void updateMemo(UserMemoVO memo);

    void updateStatus(UserStatusVO status);

}
