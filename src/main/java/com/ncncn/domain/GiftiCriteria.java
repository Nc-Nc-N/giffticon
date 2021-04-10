package com.ncncn.domain;

import lombok.Data;

@Data
public class GiftiCriteria {

	private int pageNum;
	private int amount;
	private String code;
	private String orderby;
	private String keyword;

	public GiftiCriteria(){
		this(1,12,"01","best");
	}

	public GiftiCriteria(int pageNum, int amount, String code, String orderby){
		this.pageNum = pageNum;
		this.amount = amount;
		this.code = code;
		this.orderby = orderby;
	}

	public GiftiCriteria(int pageNum, int amount, String code, String orderby, String keyword){
		this.pageNum = pageNum;
		this.amount = amount;
		this.code = code;
		this.orderby = orderby;
		this.keyword = keyword;
	}
}
