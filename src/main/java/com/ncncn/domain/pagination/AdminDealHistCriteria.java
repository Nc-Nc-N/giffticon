package com.ncncn.domain.pagination;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class AdminDealHistCriteria extends Criteria {

    private String type;
    private String keyword;

    public AdminDealHistCriteria() {
        this(1, 10, "BSNEP", "");
    }

    public AdminDealHistCriteria(int pageNum, int amount) {
        this(pageNum, amount, "BSNEP", "");
    }

    public AdminDealHistCriteria(int pageNum, int amount, String type, String keyword) {
        super(pageNum, amount);

        this.type = type;
        this.keyword = keyword;

    }

    public String[] getTypeArr() {
        return type == null ? new String[] {"B", "S", "N", "E", "P"}: type.split("");
    }

}
