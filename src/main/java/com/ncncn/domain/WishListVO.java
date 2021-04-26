package com.ncncn.domain;

import java.util.Date;

import lombok.Data;

@Data
public class WishListVO {

	private String prodCode;

	private int userId;

	private Date inDate;

	private Date upDate;

	private String bname;

	private String pname;

	private int prc;

	private int dcPrc;

	private double dcRate;

	private String imgPath;

	private String gftStusCode;

}
