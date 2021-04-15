package com.ncncn.util;

import com.ncncn.domain.UserVO;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
@Log4j
public class UserAuthCheckUtils {


    static public BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    static public boolean userAuthCheck(String userEmail, String password, UserVO userVO){

        log.info("userAuthChecking.....");
//        String encodedPwd = passwordEncoder.encode(password);

//        log.info("encodedPwd: " + encodedPwd);
        if(passwordEncoder.matches(password,userVO.getPwd()) && userEmail.equals(userVO.getEmail())){
            log.info("비밀번호가 일치합니다.");
            return true;
        }else{
            log.info("비밀번호가 다릅니다.");
            return false;
        }
    }
}
