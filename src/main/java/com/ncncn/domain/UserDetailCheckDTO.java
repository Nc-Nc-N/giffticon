package com.ncncn.domain;

import lombok.Data;

import java.util.Date;

@Data
public class UserDetailCheckDTO {

    private int id;

    private String email;

    private String name;

    private String telNo;

    private Date inDate;

    private String bankName;

    private String bankAccount;

    private int balance;

    private int dealCount;

    private int paysum;

    private int pqustCount;

    private int enabled;

    private String memo;
}
