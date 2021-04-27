package com.ncncn.service;

import java.util.List;
import java.util.Map;

import com.ncncn.domain.pagination.SaleRqustCriteria;
import com.ncncn.domain.SaleRqustVO;

public interface SaleRqustService {

	List<SaleRqustVO> getAllRqust(SaleRqustCriteria cri);

	Map<String, Object> getRqustById(int id);

	int getTotalCount(SaleRqustCriteria cri);

	int modifyStusCodeAndAprvDt(int id);

	int removeRqust(int id);
}
