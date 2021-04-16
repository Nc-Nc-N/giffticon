package com.ncncn.domain;

import lombok.Data;

import java.util.Date;

@Data
public class CsPsnlQustVO {

	private int id;

	private int  userId;

	private String title;

	private String cntnt;

	private String atchFilePath;

	private int adminId;

	private String ansCntnt;

	private Date ansInDt;

	private Date cmpltDt;

	private String csCateCode;

	private String stusCode;

	private Date inDate;

	private Date upDate;

}
