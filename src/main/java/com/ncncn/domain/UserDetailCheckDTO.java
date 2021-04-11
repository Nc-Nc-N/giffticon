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

    private int enabled;

    private String memo;

    private String bankName;

    private String bankAccount;

    private int balance;

    private int dealCount;

    private int paysum;

    private int pqustCount;

    public UserDetailCheckDTO () {}

    public UserDetailCheckDTO
            (UserDetailCheckDTOsub1 sub1,
             UserDetailCheckDTOsub2 sub2,
             UserDetailCheckDTOsub3 sub3,
             UserDetailCheckDTOsub4 sub4,
             UserDetailCheckDTOsub5 sub5)
    {
        this.id = sub1.getId();
        this.email = sub1.getEmail();
        this.name = sub1.getName();
        this.telNo = sub1.getTelNo();
        this.inDate = sub1.getInDate();
        this.enabled = sub1.getEnabled();
        this.memo = sub1.getMemo();

        this.bankName = sub2.getBankName();
        this.bankAccount = sub2.getBankAccount();

        this.balance = sub3.getBalance();

        this.dealCount = sub4.getDealCount();
        this.paysum = sub4.getPaysum();

        this.pqustCount = sub5.getPqustCount();
    }


}
