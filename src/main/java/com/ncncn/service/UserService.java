package com.ncncn.service;

import com.ncncn.domain.*;
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

    public UserInfoDTO getMyInfo(int userId);

    public int updatePwd(String pwd, String email, int userId);

    int soclUserReadByEmail(String email, String soclType);

    String checkLoginCode(String email);

    public boolean updateNameAndBirthDt(int userId, UserVO userVO);

}
