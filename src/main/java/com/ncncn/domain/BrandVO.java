package com.ncncn.domain;

import lombok.Data;

import java.util.Date;

@Data
public class BrandVO {

    private String code;

    private String cateCode;

    private String name;

    private char enabled;

    private String descn;

    private Date inDate;

    private Date upDate;

}
