package com.ncncn.domain.pagination;

import lombok.Data;

@Data
public class SaleGftCriteria extends Criteria {

    private String type;

    private String keyword;

    private String order;

    public SaleGftCriteria() {
        this(1, 5, "ENCG", "", "SJWC");
    }

    public SaleGftCriteria(int pageNum, int amount) {
        this(pageNum, amount, "ENCG", "", "SJWC");
    }

    public SaleGftCriteria(int pageNum, int amount, String type, String keyword, String order) {
        super(pageNum, amount);
        this.type = type;
        this.keyword = keyword;
        this.order = order;
    }

    public String[] getTypeArr() {
        return type == null ? new String[]{"E", "N", "C", "G"} : type.split("");
    }

    public String[] getOrderArr() {
        return order == null ? new String[]{"S", "J", "W", "C"} : order.split("");
    }
}
