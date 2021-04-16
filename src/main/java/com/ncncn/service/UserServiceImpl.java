package com.ncncn.service;

import com.ncncn.domain.UserVO;
import com.ncncn.mapper.UserMapper;
import lombok.AllArgsConstructor;
import lombok.extern.java.Log;
import org.springframework.stereotype.Service;

@Service
@Log
@AllArgsConstructor
public class UserServiceImpl implements UserService {

    UserMapper userMapper;
    SignUpService signUpService;

    @Override
    public UserVO readbyId(int userId) {

        UserVO user = userMapper.readById(userId);

        return user;
    }
}
