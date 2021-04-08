package com.ncncn.domain;

import java.util.Date;

import lombok.Data;

@Data
public class CsFaqVO {

	private int id;

	private int userId;

	private String qust;

	private String ans;

	private String csCateCode;

	private char enabled;

	private int odrNo;

	private Date inDate;

	private Date upDate;

}
