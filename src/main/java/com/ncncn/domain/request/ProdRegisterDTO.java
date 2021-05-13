package com.ncncn.domain.request;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.web.multipart.MultipartFile;

@Getter
@Setter
@ToString
public class ProdRegisterDTO {

    private String code;

    private String brdCode;

    private String name;

    private int prc;

    private double inDcRate;

    private String descn;

    private String imgPath;

    private String fileExtension;

    public void setName(String name) {
        this.name = name.trim();
    }

    public void setInDcRate(double inDcRate) {
        this.inDcRate = inDcRate * 0.01;
    }
}
