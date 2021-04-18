package com.ncncn.service;

import com.ncncn.domain.UserVO;
import com.ncncn.mapper.UserMapper;
import lombok.extern.log4j.Log4j;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@Log4j
public class SignUpServiceImpl implements SignUpService {

	private final UserMapper userMapper;
	private final PasswordEncoder passwordEncoder;

	public SignUpServiceImpl(UserMapper userMapper, PasswordEncoder passwordEncoder) {
		this.userMapper = userMapper;
		this.passwordEncoder = passwordEncoder;
	}

	public UserVO getByEmail(String email) {
		if (email == null || email.length() == 0) {
			throw new IllegalArgumentException("잘못된 사용자 이메일입니다.");
		}

		UserVO userVO = userMapper.readByEmail(email);

		if (userVO == null) {
			throw new IllegalArgumentException("해당 이메일을 사용하는 사용자가 존재하지 않습니다.");
		}

		return userVO;
	}

	public int register(UserVO userVO) {
		log.info(userVO);

		if (userVO == null) {
			throw new IllegalArgumentException("올바른 사용자 정보가 아닙니다.");
		}

		String encodedPwd = passwordEncoder.encode(userVO.getPwd());
		userVO.setPwd(encodedPwd);

		return userMapper.insert(userVO);
	}
}
