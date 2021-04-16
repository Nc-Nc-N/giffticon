package com.ncncn.domain;

import lombok.Data;

import java.util.Date;

@Data
public class GifticonVO {

    private int id;

    private int userId;

    private String prodCode;

    private int dcPrc;

    private double dcRate;

    private Date expirDt;

    private String brcd;

    private String descn;

    private String imgPath;

    private char isAutoPrc;

    private String gftStusCode;

    private Date aprvDt;

    private Date inDate;

    private Date upDate;

}
