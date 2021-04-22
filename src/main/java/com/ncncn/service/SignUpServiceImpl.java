package com.ncncn.service;

import java.sql.SQLException;

import com.ncncn.domain.UserVO;
import com.ncncn.mapper.UserMapper;
import com.ncncn.util.UserValidator;
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

	public int register(UserVO userVO) throws IllegalArgumentException {
		checkValidateUser(userVO);

		String encodedPwd = passwordEncoder.encode(userVO.getPwd());
		userVO.setPwd(encodedPwd);

		int result = 0;
		try {
			result = userMapper.insert(userVO);
		} catch (Exception e) {
			throw new IllegalArgumentException("가입중 문제가 발생했습니다.");
		}

		return result;
	}

	private void checkValidateUser(UserVO userVO) {
		if (userVO == null) throw new IllegalArgumentException("유효하지 않은 사용자 정보입니다.");
		if (!UserValidator.checkEmail(userVO.getEmail())) throw new IllegalArgumentException("유효하지 않은 이메일 형식입니다.");
		if (!UserValidator.checkPassword(userVO.getPwd())) throw new IllegalArgumentException("유효하지 않은 비밀번호 형식입니다.");
		if (!UserValidator.checkName(userVO.getName())) throw new IllegalArgumentException("유효하지 않은 이름 형식입니다.");
		if (!UserValidator.checkTelNo(userVO.getTelNo())) throw new IllegalArgumentException("유효하지 않은 휴대폰 번호 형식입니다.");
		if (!UserValidator.checkEmlAuthTkn(userVO.getEmlAuthTkn())) throw new IllegalArgumentException("유효하지 않은 인증코드입니다.");
	}
}
