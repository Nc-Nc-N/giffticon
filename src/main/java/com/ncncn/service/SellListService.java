package com.ncncn.service;

import com.ncncn.domain.CriteriaSM;
import com.ncncn.domain.MySellDTO;

import java.util.List;

public interface SellListService {

    public int countSellList(int userId, CriteriaSM cri);

    public List<MySellDTO> getSellsWithPaging(int userId, CriteriaSM cri);

    public List<MySellDTO> getSellDetail(int gftId, int userId);

    public int countStus001N002(int userId, String stusName);

}
