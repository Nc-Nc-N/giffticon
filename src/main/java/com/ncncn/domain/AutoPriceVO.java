package com.ncncn.domain;

import lombok.Data;

import java.util.Date;

@Data
public class AutoPriceVO {

    private int id;

    private String prodCode;

    private int prc;

    private int dcPrc;

    private double inDcRate;

    private double dcRate;

    private Date expirDt;

    private String stusCode;
}
