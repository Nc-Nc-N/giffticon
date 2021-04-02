package com.ncncn.domain;

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

}
