package com.ncncn.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;

@Getter
@Setter
@ToString
public class CriteriaSM {

    private String dateFrom;
    private String dateTo;

    private int pageNum;
    private int amount;

    private String type;
    private String keyword;

    public CriteriaSM(){
        this(1,3);
    }

    public CriteriaSM(int pageNum, int amount){
        this.pageNum = pageNum;
        this.amount = amount;
    }

    public String[] getTypeArr(){

        return type == null? new String[] {}: type.split("");
    }
}
