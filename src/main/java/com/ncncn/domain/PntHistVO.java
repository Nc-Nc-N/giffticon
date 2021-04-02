package com.ncncn.domain;

import lombok.Data;

import java.util.Date;

@Data
public class PntHistVO {

	private int id;

	private int userId;

	private int dealId;

	private Date chgDt;

	private int chgQuty;

	private int balance;

	private String pntHistCode;

}
