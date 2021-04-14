package com.ncncn.domain;

import lombok.Data;

import java.util.Date;

@Data
public class ProdListVO {

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

	private Date aprvDt;

	private String gftStusCode;

	private String bname;

	private String pname;

	private String pimgPath;

	private int prc;

	private int soldQuty;

	private int totProd;

	private String brdCode;

	private Date inDate;

	private Date upDate;

}
