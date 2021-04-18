package com.ncncn.service;

import com.ncncn.domain.UserInfoDTO;
import com.ncncn.mapper.UserInfoMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;

@Service
@Log4j
@AllArgsConstructor
public class UserInfoServiceImpl implements UserInfoService{

    UserInfoMapper userInfoMapper;

    @Override
    public UserInfoDTO getMyInfo(int userId){

        log.info("GetMyInfo service of " + userId);

        try {

            UserInfoDTO user = userInfoMapper.getMyInfo(userId);

            return user;

        }catch (Exception e){

            log.info("해당 사용자 정보가 없습니다.");

            return new UserInfoDTO();

        }
    }
}
