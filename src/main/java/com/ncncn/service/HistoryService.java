package com.ncncn.service;

import com.ncncn.domain.AdminDealHistVO;
import com.ncncn.domain.pagination.AdminConHistCriteria;
import com.ncncn.domain.pagination.AdminDealHistCriteria;
import com.ncncn.domain.pagination.UserCheckCriteria;

import java.util.List;
import java.util.Map;

public interface HistoryService {

    public List<AdminDealHistVO> getAdminDealHist(AdminDealHistCriteria cri);

    int getTotal(AdminDealHistCriteria cri);

    List<Map<String, String>> getAdminConHist(AdminConHistCriteria cri);

    int getConTotal(AdminConHistCriteria cri);

}
