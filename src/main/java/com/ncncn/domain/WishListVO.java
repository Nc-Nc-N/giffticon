package com.ncncn.domain;

import java.util.Date;

import lombok.Data;

@Data
public class WishListVO {

	private String prodCode;

	private int userId;

	private Date inDate;

	private Date upDate;

}
