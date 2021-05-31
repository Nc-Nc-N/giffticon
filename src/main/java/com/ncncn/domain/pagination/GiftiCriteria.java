package com.ncncn.domain.pagination;

import lombok.Data;

@Data
public class GiftiCriteria extends Criteria {

	private String code;
	private String orderby;
	private String keyword;

	public GiftiCriteria(){
		this(1,12);
	}

	public GiftiCriteria(int pageNum, int amount){
		super(pageNum, amount);
	}

	public GiftiCriteria(int pageNum, int amount, String code, String orderby){

        super(pageNum, amount);
		this.code = code;
		this.orderby = orderby;
	}

	public GiftiCriteria(int pageNum, int amount, String code, String orderby, String keyword){

		super(pageNum, amount);
		this.code = code;
		this.orderby = orderby;
		this.keyword = keyword;
	}
}
