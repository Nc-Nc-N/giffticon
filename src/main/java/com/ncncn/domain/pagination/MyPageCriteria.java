package com.ncncn.domain.pagination;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MyPageCriteria extends Criteria {

	private String dateFrom;
	private String dateTo;

	private String type;
	private String keyword;

	public MyPageCriteria() {
		this(1, 4);
	}

	public MyPageCriteria(int pageNum, int amount) {
		super(pageNum, amount);
	}

	public String[] getTypeArr() {
		return type == null ? new String[]{} : type.split("");
	}
}
