package com.ncncn.mapper;

import com.ncncn.domain.UserVO;
import org.apache.ibatis.annotations.Param;

public interface UserMapper {

    UserVO readByEmail(String email);

    int insert(UserVO userVO);

    int deleteByEmail(String email);

    UserVO readForLogin(String email);

    UserVO readById(@Param("userId") int userId);
}