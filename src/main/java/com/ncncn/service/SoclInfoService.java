package com.ncncn.service;

import com.ncncn.domain.SoclInfoForSessionDTO;

import java.util.Map;

public interface SoclInfoService {

    public SoclInfoForSessionDTO getSoclType(int userId);

    public Map<String, String> getSoclLoginCode();

    public boolean RegisterSoclUser(int userId, String soclType);

    boolean changeUserAsSocl(String roleName, String name, String email);

}
