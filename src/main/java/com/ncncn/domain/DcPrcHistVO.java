package com.ncncn.domain;

import lombok.Data;

import java.util.Date;

@Data
public class DcPrcHistVO {

	private int id;

	private int gftId;

	private Date startDt;

	private Date endDt;

	private Date inDate;

	private Date upDate;

}
