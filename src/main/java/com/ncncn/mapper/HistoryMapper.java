package com.ncncn.mapper;

import com.ncncn.domain.AdminDealHistVO;
import com.ncncn.domain.pagination.AdminConHistCriteria;
import com.ncncn.domain.pagination.AdminDealHistCriteria;

import java.util.List;
import java.util.Map;

public interface HistoryMapper {

    List<AdminDealHistVO> getAdminDealHistWithPaging(AdminDealHistCriteria cri);

    int getTotalCount(AdminDealHistCriteria cri);

    List<Map<String, String>> getAdminConHistWithPaging(AdminConHistCriteria cri);

    int getConTotalCount(AdminConHistCriteria cri);
}
