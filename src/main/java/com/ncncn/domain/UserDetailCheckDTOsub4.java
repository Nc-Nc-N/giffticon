package com.ncncn.domain;

import lombok.Data;

@Data
public class UserDetailCheckDTOsub4 {

    private int dealCount;

    private int paysum;

    public UserDetailCheckDTOsub4() {
        this.dealCount = 0;
        this.paysum = 0;
    }

}
