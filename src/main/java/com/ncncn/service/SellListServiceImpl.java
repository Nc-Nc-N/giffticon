package com.ncncn.service;

import com.ncncn.domain.pagination.MyPageCriteria;
import com.ncncn.domain.MySellVO;
import com.ncncn.mapper.SellListMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
@Log4j
public class SellListServiceImpl implements SellListService{

    SellListMapper sellListMapper;

    @Override
    public int countSellList(int userId, MyPageCriteria cri){

        log.info("counting sellList of user = " + userId);

        return sellListMapper.countSellList(userId, cri.getDateFrom(), cri.getDateTo(),
                cri.getKeyword(), cri.getType(), cri.getTypeArr());
    }

    @Override
    public List<MySellVO> getSellsWithPaging(int userId, MyPageCriteria cri){

        log.info("get Sell List of userId = " + userId);

        return sellListMapper.getSellsWithPaging(userId, cri.getDateFrom(), cri.getDateTo(),
                cri.getAmount(), cri.getPageNum(), cri.getKeyword(), cri.getType(), cri.getTypeArr());
    }

    @Override
    public MySellVO getSellDetail(int gftId, int userId){

        log.info("get Sell Details....");

        return sellListMapper.getSellDetail(gftId, userId);
    }

    @Override
    public int countStus001N002(int userId, String stusName) {

        log.info("count Status = " + stusName);

        return sellListMapper.countStus001N002(userId, stusName);
    }
}
