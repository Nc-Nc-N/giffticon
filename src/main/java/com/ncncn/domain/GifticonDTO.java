package com.ncncn.domain;

import lombok.Data;

import java.util.Date;

@Data
public class GifticonDTO {

    private int id;

    private int userId;

    private String prodCode;

    private int dcPrc;

    private double dcRate;

    private Date expirDt;

    private String brcd;

    private String descn;

    private String imgPath;

    private char isAutoPc;

    private String gftStusCode;

}
