package com.ncncn.domain;

import lombok.Data;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import java.util.List;

@Data
public class UserVO {

    private int id;

    private String email;

    private String pwd;

    private String name;

    private String telNo;

    private int pnt;

    private String memo;

    private String emlAuthTkn;

    private String stusCode;

    private String roleCode;
    


}
