package com.ncncn.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.Date;

@Data
public class UserVO {

    private int id;

    private String email;

    private String pwd;

    private String name;

    private String birthDt;

    private String telNo;

    private String birthDt;

    private int pnt;

    private String memo;

    private String emlAuthTkn;

    private int enabled;

    private String roleCode;

    private Date inDate;

    private Date upDate;

}
