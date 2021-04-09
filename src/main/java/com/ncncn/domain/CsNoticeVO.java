package com.ncncn.domain;

import lombok.Data;

import java.util.Date;

@Data
public class CsNoticeVO {

	private int id;

	private int userId;

	private String title;

	private String cntnt;

	private String csCateCode;

	private Date startDt;

	private Date endDt;

	private char isFixed;

	private String inUser;

	private String upUser;
}
