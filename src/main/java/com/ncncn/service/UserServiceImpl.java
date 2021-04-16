package com.ncncn.service;

import com.ncncn.domain.UserVO;
import com.ncncn.mapper.UserMapper;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.java.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@Log
public class UserServiceImpl implements UserService {

    @Setter(onMethod_ = @Autowired)
    UserMapper userMapper;

    @Override
    public UserVO readbyId(int userId) {

        UserVO user = userMapper.readById(userId);

        return user;
    }
	@Override
	public int countRecentlyRegister() {
		return userMapper.countRecentlyInsert();
	}
}
