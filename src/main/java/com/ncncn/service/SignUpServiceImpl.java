package com.ncncn.service;

import java.sql.SQLException;

import com.ncncn.domain.UserVO;
import com.ncncn.mapper.UserMapper;
import com.ncncn.util.EmailAuthCodeUtils;
import com.ncncn.util.SendMmsMessage;
import com.ncncn.util.UserValidator;
import lombok.extern.log4j.Log4j;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@Log4j
public class SignUpServiceImpl implements SignUpService {

	private final UserMapper userMapper;
	private final PasswordEncoder passwordEncoder;
	private final SendMmsMessage sendMmsMessage;

	public SignUpServiceImpl(UserMapper userMapper, PasswordEncoder passwordEncoder, SendMmsMessage sendMmsMessage) {
		this.userMapper = userMapper;
		this.passwordEncoder = passwordEncoder;
		this.sendMmsMessage = sendMmsMessage;
	}

	public UserVO getUserByEmail(String email) {
		return userMapper.readUserByEmail(email);
	}

	public boolean isEmailExists(String email) {
		return userMapper.readUserByEmail(email) != null;
	}

	public int register(UserVO userVO) throws Exception {
		// 입력받은 생년월일 값이 없으면 null값 저장
		if (userVO.getBirthDt().equals("")) {
			userVO.setBirthDt(null);
		}

		checkValidateUser(userVO);

		String encodedPwd = passwordEncoder.encode(userVO.getPwd());
		userVO.setPwd(encodedPwd);

		int result = 0;
		try {
			result = userMapper.insertUser(userVO);
		} catch (Exception e) {
			// e가 가진 정보를 그대로 전달
			// 새로운 예외를 던지더라도 원인예외를 포함해야함
			SQLException sqlException = new SQLException("회원등록중 문제가 발생했습니다.");
			sqlException.initCause(e);        // 원인예외를 포함
			throw sqlException;
		}

		return result;
	}

	@Override
	public void sendAuthCode(String telNo, String code) throws Exception {
		String responseCode = sendMmsMessage.sendAuthCode(telNo, code);
		log.info(responseCode);
		checkMmsResponse(responseCode);
	}

	private void checkMmsResponse(String responseCode) throws Exception {
		if (!responseCode.contains("ok")) {
			throw new Exception(responseCode);
		}
	}

	private void checkValidateUser(UserVO userVO) {
		if (userVO == null) {
			throw new IllegalArgumentException("유효하지 않은 사용자 정보입니다.");
		}
		if (isEmailExists(userVO.getEmail())) {
			throw new IllegalArgumentException("이미 가입된 이메일입니다.");
		}
		if (!UserValidator.checkEmail(userVO.getEmail())) {
			throw new IllegalArgumentException("유효하지 않은 이메일 형식입니다.");
		}
		if (!UserValidator.checkPassword(userVO.getPwd())) {
			throw new IllegalArgumentException("유효하지 않은 비밀번호 형식입니다.");
		}
		if (!UserValidator.checkName(userVO.getName())) {
			throw new IllegalArgumentException("유효하지 않은 이름 형식입니다.");
		}
		if (!UserValidator.checkBirthDt(userVO.getBirthDt())) {
			throw new IllegalArgumentException("유효하지 않은 생년월일 형식입니다.");
		}
		if (!UserValidator.checkTelNo(userVO.getTelNo())) {
			throw new IllegalArgumentException("유효하지 않은 휴대폰 번호 형식입니다.");
		}
		if (!UserValidator.checkEmlAuthTkn(userVO.getEmlAuthTkn())) {
			throw new IllegalArgumentException("유효하지 않은 인증코드입니다.");
		}
	}

}