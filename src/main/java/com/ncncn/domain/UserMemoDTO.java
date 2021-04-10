package com.ncncn.domain;

import lombok.Data;

@Data
public class UserMemoDTO {

    private int id;

    private String memo;

    public UserMemoDTO(){
        this.id=152;
        this.memo="Test Memo";

    }

}
