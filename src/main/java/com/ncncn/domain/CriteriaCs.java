package com.ncncn.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CriteriaCs extends Criteria{

//	private int pageNum;
//	private int amount;

	private String type;
	private String keyword;

	public CriteriaCs(){
		this(1,10,"NE","");
	}

	public CriteriaCs(int pageNum, int amount) {
		this(pageNum,amount,"NE","");
	}

	public CriteriaCs(int pageNum, int amount, String type, String keyword){
//		this.pageNum = pageNum;
//		this.amount = amount;
		super(pageNum, amount);
		this.type = type;
		this.keyword = keyword;
	}

	public String[] getTypeArr(){

		return type == null? new String[] {"N", "E"}: type.split("");
	}
}
