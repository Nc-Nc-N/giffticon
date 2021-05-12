package com.ncncn.domain;

import java.util.Date;

import lombok.Data;

@Data
public class AgreVO {

	private int id;

	private Date agreDt;

	private char agreYn;

	private int userId;

	private int termsId;

	private Date inDate;

	private Date upDate;

}