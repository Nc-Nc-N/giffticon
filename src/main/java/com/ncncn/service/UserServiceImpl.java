package com.ncncn.service;

import com.ncncn.domain.UserInfoDTO;
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

    @Override
    public UserInfoDTO getMyInfo(int userId){

        log.info("GetMyInfo service of " + userId);

        try {

            UserInfoDTO user = userMapper.getMyInfo(userId);

            return user;

        }catch (Exception e){

            log.info("해당 사용자 정보가 없습니다.");

            return new UserInfoDTO();

        }
    }
}
