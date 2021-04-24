package com.ncncn.domain.pagination;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class UserCheckCriteria extends Criteria {

    private String type;
    private String keyword;

    public UserCheckCriteria() {
        this(1, 10, "NET", "");
    }

    public UserCheckCriteria(int pageNum, int amount) {
        this(pageNum, amount, "NET", "");
    }

    public UserCheckCriteria(int pageNum, int amount, String type, String keyword) {
        super(pageNum, amount);

        this.type = type;
        this.keyword = keyword;

    }

    public String[] getTypeArr() {
        return type == null ? new String[] {"N", "E", "T"}: type.split("");
    }

}
