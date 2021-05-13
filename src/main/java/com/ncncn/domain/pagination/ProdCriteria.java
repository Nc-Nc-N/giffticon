package com.ncncn.domain.pagination;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProdCriteria extends Criteria {

    private String type;

    private String keyword;

    public ProdCriteria() {
        this(1, 5, "CBPD", "");
    }

    public ProdCriteria(int pageNum, int amount) {
        this(pageNum, amount, "CBPD", "");
    }

    public ProdCriteria(int pageNum, int amount, String type, String keyword) {
        super(pageNum, amount);
        this.type = type;
        this.keyword = keyword;
    }

    public String[] getTypeArr() {
        return type == null ? new String[]{"C", "B", "P", "D"} : type.split("");
    }

}
