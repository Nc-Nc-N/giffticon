package com.ncncn.service;

import com.ncncn.domain.CmmnCodeVO;
import com.ncncn.domain.SoclInfoForSessionDTO;
import com.ncncn.mapper.SoclInfoMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ServerErrorException;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Log4j
public class SoclInfoServiceImpl implements SoclInfoService {

    @Setter(onMethod_ = @Autowired)
    SoclInfoMapper soclInfoMapper;

    @Override
    public SoclInfoForSessionDTO getSoclType(int userId) {

        SoclInfoForSessionDTO soclInfoForSessionDTO = soclInfoMapper.getSocialInfo(userId);

        return soclInfoForSessionDTO;
    }

    @Override
    public Map<String,String> getSoclLoginCode(){

        List<CmmnCodeVO> typeList ;
        typeList = soclInfoMapper.getSocialType();

        Map<String,String> soclTypes = new HashMap<>();

        for(int i=0; i< typeList.size(); i++){

            soclTypes.put(typeList.get(i).getCodeName(),typeList.get(i).getCode());
        }

        return soclTypes;
    }

    @Override
    public boolean RegisterSoclUser(int userId, String soclType){

        try {
            int isRegistered = soclInfoMapper.insertSocialInfo(userId, soclType);
            return true;
        }catch (Exception e){
            throw new ServerErrorException("소셜유저등록에 실패했습니다.");
        }
    }

    @Override
    public boolean changeUserAsSocl(String roleName, String name, String email) {

        if(roleName.equals("사용자")){
            log.info("사용자로 변경 합니다.");
        }else if (roleName.equals("관리자")){
            log.info("관리자로 변경합니다.");
        }else if(roleName.equals("사용자(소셜로그인)")){
            log.info("소셜유저로 변경합니다.");
        }else{
            log.info("등록되지 않은 role 입니다. role name을 확인해주세요");
            return false;
        }

        int isUpdated = 0;
        try{
            isUpdated = soclInfoMapper.updateUserRole(roleName, name, email);
        }catch (Exception e){
            return false;
//            throw new ServerException("서버오류로 업데이트에 실패했습니다.");
        }

        if(isUpdated == 1){
            return true;
        }else{
            return false;
//            throw new InterruptedException("기존 유저 정보가 없습니다. 관리자에게 문의해주세요");
        }
    }
}
