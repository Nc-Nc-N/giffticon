package com.ncncn.domain.pagination;

import lombok.Data;

@Data
public class GiftiCriteria extends Criteria {

//	private int pageNum;
//	private int amount;
	private String code;
	private String orderby;
	private String keyword;

	public GiftiCriteria(){
		this(1,12,"0","best");
	}

	public GiftiCriteria(int pageNum, int amount, String code, String orderby){
//		this.pageNum = pageNum;
//		this.amount = amount;
        super(pageNum, amount);
		this.code = code;
		this.orderby = orderby;
	}

	public GiftiCriteria(int pageNum, int amount, String code, String orderby, String keyword){
//		this.pageNum = pageNum;
//		this.amount = amount;
		super(pageNum, amount);
		this.code = code;
		this.orderby = orderby;
		this.keyword = keyword;
	}
}
