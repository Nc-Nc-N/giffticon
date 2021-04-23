package com.ncncn.domain.pagination;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CsCriteria extends Criteria {

	private String type;
	private String keyword;

	public CsCriteria(){
		this(1,10,"NE","");
	}

	public CsCriteria(int pageNum, int amount) {
		this(pageNum,amount,"NE","");
	}

	public CsCriteria(int pageNum, int amount, String type, String keyword){
		super(pageNum, amount);
		this.type = type;
		this.keyword = keyword;
	}

	public String[] getTypeArr(){
		return type == null? new String[] {"N", "E"}: type.split("");
	}
}
