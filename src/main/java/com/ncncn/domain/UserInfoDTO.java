package com.ncncn.domain;

import lombok.Data;

@Data
public class UserInfoDTO {

    private String email;

    private int id;

    private String pwd;

    private String telNo;

    private String name;

    private String acc;

    private String bnkCode;

    private String bnkName;

    private String holder;

    private char isAuthed;

}
