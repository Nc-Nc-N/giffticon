package com.ncncn.mapper;

import com.ncncn.domain.UserInfoDTO;
import com.ncncn.domain.UserDetailCheckVO;
import com.ncncn.domain.UserMemoVO;
import com.ncncn.domain.UserStatusVO;
import com.ncncn.domain.UserVO;
import com.ncncn.domain.pagination.UserCheckCriteria;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper {

    UserVO readByEmail(String email);

    int insert(UserVO userVO);

    int deleteByEmail(String email);

    UserVO readForLogin(String email);

    UserVO readById(@Param("userId") int userId);

    int countRecentlyInsert();

    List<UserVO> getUserList();

    List<UserVO> getListWithPaging(UserCheckCriteria cri);

    int getTotalCount(UserCheckCriteria cri);

    UserDetailCheckVO getUserDetail(int userId);

    void updateMemo(UserMemoVO memo);

    void updateStatus(UserStatusVO status);

    public UserInfoDTO getMyInfo(int userId);

    int updatePwd(@Param("pwd") String pwd,
                  @Param("email") String email,
                  @Param("userId") int userId);
}

