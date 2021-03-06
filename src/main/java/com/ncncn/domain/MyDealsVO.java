package com.ncncn.domain;

import lombok.Data;

import java.util.Date;

@Data
public class MyDealsVO {

    //from deal_detail
    private int dealId;

    //from gifticon
    private int gftId;

    //from gifticon
    private String gftImgPath;

    //from gifticon
    private String brcd;

    //from deal_detail
    private int csId;

    //from gifticon
    private String brdName;

    //from product
    private String prdName;

    //from product
    private String prdImgPath;

    //from product
    private String prdCode;

    //from deal_detail
    private int pymtPrc;

    //from stus_code
    private String stusCode;

    //from deal_detail
    private Date dealDt;

    //from gifticon
    private Date exprDt;



}
