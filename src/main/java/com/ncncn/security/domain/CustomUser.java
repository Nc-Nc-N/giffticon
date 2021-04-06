package com.ncncn.security.domain;

import com.ncncn.domain.UserVO;
import lombok.Getter;
import lombok.extern.log4j.Log4j;
import org.springframework.security.config.core.GrantedAuthorityDefaults;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.stream.Collector;

@Getter
@Log4j
public class CustomUser extends User {

    private static final long serialVersionUID = 1L;

    private UserVO user;

    public CustomUser(UserVO vo){
        super(vo.getEmail(), vo.getPwd(),
                Arrays.asList(new SimpleGrantedAuthority(vo.getRoleCode())));
        log.info("User Info : " + vo);
    }
}
