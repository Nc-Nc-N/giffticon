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

	private String type;
	private String keyword;

	public CriteriaCs(){
		this(1,10,"NE","");
	}

//	public CriteriaCs(String type){this(1,10,type,"");}

	public CriteriaCs(int pageNum, int amount) {
		this(pageNum,amount,"NE","");
	}

//	public CriteriaCs(int pageNum, int amount, String type){ this(pageNum, amount, type, ""); }

	public CriteriaCs(int pageNum, int amount, String type, String keyword){
		this.pageNum = pageNum;
		this.amount = amount;
		this.type = type;
		this.keyword = keyword;
	}

	public String[] getTypeArr(){

		return type == null? new String[] {"N", "E"}: type.split("");
	}
}
