package com.ncncn.service;

import com.ncncn.domain.UserVO;

public interface SignUpService {

	UserVO getByEmail(String email);

	int register(UserVO userVO) throws Exception;

}
