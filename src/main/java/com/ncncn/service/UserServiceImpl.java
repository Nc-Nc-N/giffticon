package com.ncncn.service;

import com.ncncn.mapper.UserMapper;
import lombok.extern.log4j.Log4j;

import org.springframework.stereotype.Service;

@Service
@Log4j
public class UserServiceImpl implements UserService {

	private UserMapper userMapper;

	public UserServiceImpl(UserMapper userMapper) {
		this.userMapper = userMapper;
	}

	@Override
	public int countRecentlyRegister() {
		return userMapper.countRecentlyInsert();
	}
}
