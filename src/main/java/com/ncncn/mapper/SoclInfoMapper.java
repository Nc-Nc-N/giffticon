package com.ncncn.mapper;

import com.ncncn.domain.CmmnCodeVO;
import com.ncncn.domain.SoclInfoForSessionDTO;

import java.util.List;
import java.util.Map;

public interface SoclInfoMapper {

    SoclInfoForSessionDTO getSocialInfo(int userId);

    List<CmmnCodeVO> getSocialType();
}
