package com.ncncn.domain;

import lombok.Data;

@Data
public class AttachFileDTOCH {

    private String fileName;
    private String uploadPath;
    private String uuid;
    private boolean image;
}
