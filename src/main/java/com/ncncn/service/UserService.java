package com.ncncn.service;

import com.ncncn.domain.UserInfoDTO;
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

    int getTotal(UserCheckCriteria cri);

    UserDetailCheckVO getUserDetail(int userId);

    void updateMemo(UserMemoVO memo);

    void updateStatus(UserStatusVO status);

    public UserInfoDTO getMyInfo(int userId);

}
