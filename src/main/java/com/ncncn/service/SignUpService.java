package com.ncncn.service;

import com.ncncn.domain.UserVO;

public interface SignUpService {

	UserVO findByEmail(String email);

	int register(UserVO userVO);

}
