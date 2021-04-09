package com.ncncn.mapper;

import com.ncncn.domain.CriteriaCH;
import com.ncncn.domain.UserDetailCheckDTO;
import com.ncncn.domain.UserVO;

import java.util.List;

public interface UserCheckMapper {

    public List<UserVO> getUserList();

    public List<UserVO> getListWithPaging(CriteriaCH cri);

    public int getTotalCount(CriteriaCH cri);

    public UserDetailCheckDTO getUserDetail(int userId);

}
