package com.ncncn.domain;

import lombok.Data;

@Data
public class PrcUpdateVO {

    private String email;

    private String password;

    private int gftId;

    private char isAutoPrc;

    private int dcPrc;

    private double dcRate;

}
