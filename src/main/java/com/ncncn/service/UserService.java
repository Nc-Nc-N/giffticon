package com.ncncn.service;

import com.ncncn.domain.UserInfoDTO;
import com.ncncn.domain.UserVO;

public interface UserService {

    public UserVO readbyId(int userId);

	int countRecentlyRegister();

    public UserInfoDTO getMyInfo(int userId);

}
