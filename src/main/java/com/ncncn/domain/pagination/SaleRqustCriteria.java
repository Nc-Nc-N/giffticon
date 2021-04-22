package com.ncncn.domain.pagination;

public class SaleRqustCriteria extends Criteria {

	private String type;
	private String keyword;

	public SaleRqustCriteria() {
		this(1, 5, "ENC", "");
	}

	public SaleRqustCriteria(int pageNum, int amount) {
		this(pageNum, amount, "ENC", "");
	}

	public SaleRqustCriteria(int pageNum, int amount, String type, String keyword) {
//		this.pageNum = pageNum;
//		this.amount = amount;
        super(pageNum, amount);
		this.type = type;
		this.keyword = keyword;
	}

	public String[] getTypeArr() {
		return type == null ? new String[]{"E", "N", "C"} : type.split("");
	}

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}
}
