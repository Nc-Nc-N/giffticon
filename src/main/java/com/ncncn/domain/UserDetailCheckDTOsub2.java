package com.ncncn.domain;

import lombok.Data;

@Data
public class UserDetailCheckDTOsub2 {

    private String bankName;

    private String bankAccount;

    public UserDetailCheckDTOsub2() {
        this.bankName="";
        this.bankAccount="";
    }

}
