package com.ncncn.domain;

import lombok.Data;
import java.util.Date;

@Data
public class BankAccountVO {

    private String acc;

    private int userId;

    private String bnkCode;

    private String holder;

    private char isAuthed;

    private Date authDt;

    private String accStus;

    private Date inDate;

    private Date upDate;

}
