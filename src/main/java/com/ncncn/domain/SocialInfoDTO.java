package com.ncncn.domain;

import lombok.Data;

import java.util.Date;

@Data
public class SocialInfoDTO {

    private String email;

    private String name;

    private String birthDt;

    private String telNo;

    private String soclTypeCode;

    private String tknType;

    private String accesTkn;

    private int accesTknExpirIn;

    private String rfrshTkn;

    private int rfrshTknExpirIn;
}
