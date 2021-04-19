package com.ncncn.domain;

import java.util.Date;

import lombok.*;

@Getter
@Setter
@ToString
public class SaleRqustVO {

	private int gftId;

	private String brcd;

	private Date expirDt;

	private Date inDate;

	private String imgPath;

	private String prodCode;

	private String cateName;

	private String brdName;

	private String prodName;

	private String requester;

}
