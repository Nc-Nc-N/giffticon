package com.ncncn.mapper;

import com.ncncn.domain.*;
import com.ncncn.domain.pagination.CriteriaCH;

import java.util.List;

public interface UserCheckMapper {

    public List<UserVO> getUserList();

    public List<UserVO> getListWithPaging(CriteriaCH cri);

    public int getTotalCount(CriteriaCH cri);

    public UserDetailCheckDTO getUserDetail(int userId);

    public void updateMemo(UserMemoDTO memo);

    public void updateStatus(UserStatusDTO status);

}
