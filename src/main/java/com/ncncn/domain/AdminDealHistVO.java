package com.ncncn.domain;

import lombok.Data;

import java.util.Date;

@Data
public class AdminDealHistVO {

    private int id;

    private String buyerEmail;

    private String sellerEmail;

    private int gifticonId;

    private String brdName;

    private String prodName;

    private Date dealDt;

    private Date cmplDt;

    private String codeName;

}
