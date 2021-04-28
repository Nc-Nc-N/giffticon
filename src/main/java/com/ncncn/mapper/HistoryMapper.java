package com.ncncn.mapper;

import com.ncncn.domain.AdminDealHistVO;
import com.ncncn.domain.pagination.AdminDealHistCriteria;

import java.util.List;

public interface HistoryMapper {

    List<AdminDealHistVO> getAdminDealHistWithPaging(AdminDealHistCriteria cri);

    int getTotalCount(AdminDealHistCriteria cri);
}
