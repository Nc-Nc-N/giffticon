package com.ncncn.domain;

import lombok.Data;

import java.util.Date;

@Data
public class DealDetailVO {

	private int id;
	private int userId;
	private int gifticonId;
	private int pymtPrc;
	private String pymtMtd;
	private Date dealDt;
	private Date cmplDt;

}
