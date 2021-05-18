package com.ncncn.mapper;

import com.ncncn.domain.CmmnCodeVO;
import com.ncncn.domain.SoclInfoForSessionDTO;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface SoclInfoMapper {

    SoclInfoForSessionDTO getSocialInfo(int userId);

    List<CmmnCodeVO> getSocialType();

    int insertSocialInfo(@Param("userId") int userId,
                         @Param("soclType") String soclType);

    int updateUserRole(@Param("roleName") String roleName,
                       @Param("name") String name,
                       @Param("email") String email);
}
