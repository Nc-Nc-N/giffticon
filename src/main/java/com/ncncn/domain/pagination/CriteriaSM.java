package com.ncncn.domain.pagination;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CriteriaSM extends Criteria {

    private String dateFrom;
    private String dateTo;

//    private int pageNum;
//    private int amount;

    private String type;
    private String keyword;

    public CriteriaSM() {
        this(1, 4);
    }

    public CriteriaSM(int pageNum, int amount) {
//        this.pageNum = pageNum;
//        this.amount = amount;
        super(pageNum, amount);
    }

    public String[] getTypeArr() {

        return type == null ? new String[]{} : type.split("");
    }
}
