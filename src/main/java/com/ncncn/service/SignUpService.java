package com.ncncn.service;

import com.ncncn.domain.UserVO;

public interface SignUpService {

	UserVO getUserByEmail(String email);

	boolean isEmailExists(String email);

	int register(UserVO userVO) throws Exception;

	void sendAuthCode(String telNo, String code) throws Exception;

}
