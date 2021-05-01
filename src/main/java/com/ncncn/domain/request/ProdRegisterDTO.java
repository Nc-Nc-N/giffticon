package com.ncncn.domain.request;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.web.multipart.MultipartFile;

@Getter
@Setter
@ToString
public class ProdRegisterDTO {

    private String cateCode;

    private String brdCode;

    private String name;

    private int prc;

    private int inDcRate;

    private String descn;

    private MultipartFile prodImg;

}
