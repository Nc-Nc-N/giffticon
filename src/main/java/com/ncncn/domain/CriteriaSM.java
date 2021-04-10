package com.ncncn.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CriteriaSM {

    private int pageNum;
    private int amount;

    public CriteriaSM(){
        this(1,3);
    }

    public CriteriaSM(int pageNum, int amount){
        this.pageNum = (pageNum - 1) * amount;
        this.amount = amount;
    }
}
