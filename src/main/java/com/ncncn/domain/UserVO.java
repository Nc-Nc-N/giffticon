package com.ncncn.domain;

import lombok.Data;
import java.util.Date;

@Data
public class UserVO {

	private int id;

	private String email;

	private String pwd;

	private String name;

	private String telNo;

	private int pnt;

	private String memo;

	private String emlAuthTkn;

	private int enabled;

	private String roleCode;

	private Date inDate;

	private Date upDate;

}
