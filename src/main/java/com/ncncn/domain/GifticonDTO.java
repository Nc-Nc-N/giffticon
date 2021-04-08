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

	// 브랜드 이름
	private String bname;

	// 상품 이름
	private String pname;

	// 상품 이미지
	private String pimgPath;

	// 상품 정가
	private int prc;

	// 판매량
	private int soldQuty;

}
