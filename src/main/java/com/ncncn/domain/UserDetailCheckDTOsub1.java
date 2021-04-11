package com.ncncn.domain;

import lombok.Data;

import java.util.Date;

@Data
public class UserDetailCheckDTOsub1 {

    private int id;

    private String email;

    private String name;

    private String telNo;

    private Date inDate;

    private int enabled;

    private String memo;

}
