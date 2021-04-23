package com.ncncn.mapper;

import com.ncncn.domain.*;
import com.ncncn.domain.pagination.UserCheckCriteria;

import java.util.List;

public interface UserCheckMapper {

    public List<UserVO> getUserList();

    public List<UserVO> getListWithPaging(UserCheckCriteria cri);

    public int getTotalCount(UserCheckCriteria cri);

    public UserDetailCheckDTO getUserDetail(int userId);

    public void updateMemo(UserMemoDTO memo);

    public void updateStatus(UserStatusDTO status);

}
