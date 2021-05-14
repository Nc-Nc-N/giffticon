package com.ncncn.util;

import com.ncncn.domain.UserVO;
import lombok.extern.log4j.Log4j;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.util.NoSuchElementException;

@Log4j
public class UserAuthCheckUtils {


    static public BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    //비밀번호 일치 여부 조회 메서드
    static public boolean userAuthCheck(String userEmail, String password, UserVO userVO) {

        if(userVO.getPwd() == null || userVO.getPwd().equals("")){
           throw new NoSuchElementException();
        }

        //입력된 비밀번호가 DB의 암호화된 비밀번호와 일치하는지 확인
        if (passwordEncoder.matches(password, userVO.getPwd()) && userEmail.equals(userVO.getEmail())) {
            log.info("비밀번호가 일치합니다.");
            return true;
        } else {
            log.info("비밀번호가 다릅니다.");
            return false;
        }
    }
}
