package com.ncncn.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class CriteriaCH extends Criteria{

//    private int pageNum;
//    private int amount;

    private String type;
    private String keyword;

    public CriteriaCH() {
        this(1, 10, "NET", "");
    }

    public CriteriaCH(int pageNum, int amount) {
        this(pageNum, amount, "NET", "");
    }

    public CriteriaCH(int pageNum, int amount, String type, String keyword) {
//        this.pageNum = pageNum;
//        this.amount = amount;
        super(pageNum, amount);

        this.type = type;
        this.keyword = keyword;

    }

    public String[] getTypeArr() {
        return type == null ? new String[] {"N", "E", "T"}: type.split("");
    }

}
