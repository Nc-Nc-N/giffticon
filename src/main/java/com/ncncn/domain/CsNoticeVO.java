package com.ncncn.domain;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
public class CsNoticeVO {

	private int id;

	private int userId;

	private String title;

	private String cntnt;

	private String csCateCode;

	private Date startDt;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endDt;

	private char isFixed;

	private Date inDate;

	private Date upDate;

}
