package com.ncncn.domain;

import lombok.Data;

import java.util.Date;

@Data
public class MySellDTO {

    //gifticon id
    private int id;

    //판매자 id
    private int userId;

    //신청날짜
    private Date inDt;
    //승인날짜
    private Date aprvDt;

    //브랜드이름
    private String brdName;

    //상품이름
    private String prdName;
    
    //상품번호
    private String prdCode;

    //상품이미지
    private String prdImgPath;

    //바코드이미지
    private String brcdImgPath;

    //바코드
    private String brcd;

    //유효기간
    private Date expirDt;

    //자동할인여부
    private char isAutoPrc;

    //할인률
    private double dcRate;

    //할인가
    private int dcPrc;

    //기프티콘상태
    private String codeName;

    //판매자 메세지
    private String descn;

}
