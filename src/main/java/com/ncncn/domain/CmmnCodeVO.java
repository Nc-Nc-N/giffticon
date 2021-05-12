package com.ncncn.domain;

import java.util.Date;

import lombok.Data;

@Data
public class CmmnCodeVO {

	private String code;

	private String codeName;

	private String codeType;

	private String descn;

	private char enabled;

	private Date inDate;

	private Date upDate;

}
