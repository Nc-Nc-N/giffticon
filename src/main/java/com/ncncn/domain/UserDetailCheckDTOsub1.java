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

    public UserDetailCheckDTOsub1() {
        this.id=0;
        this.email="";
        this.name="";
        this.telNo="";
        this.inDate=new Date(99999999);

        this.enabled=0;
        this.memo="";
    }

}
