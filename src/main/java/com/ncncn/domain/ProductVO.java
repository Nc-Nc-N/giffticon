package com.ncncn.domain;

import lombok.Data;

import java.util.Date;

@Data
public class ProductVO {

    private String code;

    private String brdCode;

    private String name;

    private int prc;

    private String descn;

    private double inDcRate;

    private String imgPath;

    private int regQuty;

    private int soldQuty;

    private char enabled;

    private Date inDate;

    private Date upDate;

}
