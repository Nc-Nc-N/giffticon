package com.ncncn.mapper;

import com.ncncn.domain.UserVO;

public interface UserMapper {

    UserVO readByEmail(String email);

    int insert(UserVO userVO);

    int deleteByEmail(String email);

    UserVO readForLogin(String email);
}