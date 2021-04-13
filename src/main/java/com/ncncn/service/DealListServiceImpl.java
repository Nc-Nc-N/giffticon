package com.ncncn.service;

import com.ncncn.domain.CriteriaSM;
import com.ncncn.domain.MyDealsDTO;
import com.ncncn.mapper.DealListMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j
@Service
@AllArgsConstructor
public class DealListServiceImpl implements DealListService {

    private DealListMapper dealListMapper;

    @Override
    public List<MyDealsDTO> getGftDetail(int gftId) {

        log.info("Get Detail of gft Id: " + gftId);

        return dealListMapper.getGftDetail(gftId);
    }

    @Override
    public List<MyDealsDTO> getDealsWithPaging(String email, CriteriaSM cri) {
        log.info("Service of Get Deals with Paging....");

        return dealListMapper.getDealsWithPaging(email, cri.getDateFrom(), cri.getDateTo(),
                cri.getAmount(), cri.getPageNum(), cri.getKeyword(), cri.getType(), cri.getTypeArr());
    }

    @Override
    public int countDealList(String email, CriteriaSM cri) {
        log.info("Count " + email + "'s deal list....");

        return dealListMapper.countDealList(email, cri.getDateFrom(), cri.getDateTo(),
                cri.getKeyword(), cri.getType(), cri.getTypeArr());
    }

    @Override
    public int countStus004(int userId) {

        log.info("Count status 004....");

        return dealListMapper.countStus004(userId);
    }

    @Override
    public int countStus001N002(int userId, String stusName) {

        log.info("count Status = " + stusName);

        return dealListMapper.countStus001N002(userId, stusName);
    }

}
