package com.ncncn.domain;

import lombok.Data;

import java.util.Date;

@Data
public class MyDealsDTO {

    //from deal_detail
    private int dealId;

    //from user
    private String userId;

    //from gifticon
    private String brdName;

    //from product
    private String prdName;

    //from gifticon
    private String imgPath;

    //from deal_detail
    private int pymtPrc;

    //from stus_code
    private String stusCode;

    //from deal_detail
    private Date dealDt;

}
