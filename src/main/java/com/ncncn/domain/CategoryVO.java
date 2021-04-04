package com.ncncn.domain;

import lombok.Data;

import java.util.Date;

@Data
public class CategoryVO {

    private String code;

    private String name;

    private char enabled;

    private String descn;

    private Date inDate;

    private String inUser;

    private Date upDate;

    private String upUser;

}
