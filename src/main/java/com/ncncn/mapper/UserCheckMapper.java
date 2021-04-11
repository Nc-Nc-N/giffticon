package com.ncncn.mapper;

import com.ncncn.domain.*;

import java.util.List;

public interface UserCheckMapper {

    public List<UserVO> getUserList();

    public List<UserVO> getListWithPaging(CriteriaCH cri);

    public int getTotalCount(CriteriaCH cri);

    public UserDetailCheckDTO getUserDetail(int userId);

    public UserDetailCheckDTOsub1 getUserDetailSub1(int userId);
    public UserDetailCheckDTOsub2 getUserDetailSub2(int userId);
    public UserDetailCheckDTOsub3 getUserDetailSub3(int userId);
    public UserDetailCheckDTOsub4 getUserDetailSub4(int userId);
    public UserDetailCheckDTOsub5 getUserDetailSub5(int userId);

    public void updateMemo(UserMemoDTO memo);

    public void updateStatus(UserStatusDTO status);

}
