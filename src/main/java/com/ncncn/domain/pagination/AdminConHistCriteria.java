package com.ncncn.domain.pagination;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class AdminConHistCriteria extends Criteria {
    private String dateFrom;
    private String dateTo;

    private String type;
    private String keyword;

    public AdminConHistCriteria() {
        this(1, 10, "EN", "");
    }

    public AdminConHistCriteria(int pageNum, int amount) {
        this(pageNum, amount, "EN", "");
    }

    public AdminConHistCriteria(int pageNum, int amount, String type, String keyword) {
        super(pageNum, amount);

        this.type = type;
        this.keyword = keyword;

    }

    public String[] getTypeArr() {
        return type == null ? new String[] {"E", "N"}: type.split("");
    }

}
