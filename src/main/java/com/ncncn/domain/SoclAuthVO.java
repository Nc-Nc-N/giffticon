package com.ncncn.domain;

import java.util.Date;

import lombok.Data;

@Data
public class SoclAuthVO {

	private int userId;

	private String soclTypeCode;

	private String tknType;

	private String accesTkn;

	private int accesTknExpirIn;

	private String rfrshTkn;

	private int rfrshTknExpirIn;

	private Date inDate;

	private Date upDate;

}
