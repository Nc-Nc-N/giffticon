package com.ncncn.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CriteriaCs {

	private int pageNum;

	private int amount;

	public CriteriaCs(){
		this(1,10);
	}

	public CriteriaCs(int pageNum, int amount){
		this.pageNum = pageNum;
		this.amount = amount;
	}
}
