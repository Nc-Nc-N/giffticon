package com.ncncn.domain;

import lombok.Data;

import java.util.Date;

@Data
public class MySellVO {

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

    //시작할인률
    private double startDcRate;

    //최종 할인률
    private double finalDcRate;

    //정가
    private int listPrc;

    //할인가
    private int dcPrc;

    //기프티콘상태
    private String codeName;

    //판매자 메세지
    private String descn;

}
