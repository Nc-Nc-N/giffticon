package com.ncncn.service;

import com.ncncn.domain.AdminDealHistVO;
import com.ncncn.domain.pagination.AdminConHistCriteria;
import com.ncncn.domain.pagination.AdminDealHistCriteria;
import com.ncncn.mapper.HistoryMapper;
import com.ncncn.mapper.UserMapper;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Log4j
@Service
@AllArgsConstructor
public class HistoryServiceImpl implements HistoryService{

    @Setter(onMethod_ = @Autowired)
    HistoryMapper historyMapper;

    @Override
    public List<AdminDealHistVO> getAdminDealHist(AdminDealHistCriteria cri) {
        log.info("get admin deal hist list..............");

        return historyMapper.getAdminDealHistWithPaging(cri);
    }

    @Override
    public int getTotal(AdminDealHistCriteria cri) {

        log.info("get total count");
        return historyMapper.getTotalCount(cri);
    }

    @Override
    public List<Map<String, String>> getAdminConHist(AdminConHistCriteria cri) {
        log.info("get admin con hist list...............");

        return historyMapper.getAdminConHistWithPaging(cri);
    }

    @Override
    public int getConTotal(AdminConHistCriteria cri) {

        log.info("get total count con");
        return historyMapper.getConTotalCount(cri);
    }
}
