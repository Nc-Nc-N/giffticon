package com.ncncn.service;

import com.ncncn.domain.*;
import com.ncncn.domain.pagination.CriteriaCH;
import com.ncncn.mapper.UserCheckMapper;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Log4j
@Service
@AllArgsConstructor
public class UserCheckServiceImpl implements UserCheckService {

    @Setter(onMethod_ = @Autowired)
    private UserCheckMapper mapper;

    // 299page
    @Override
    public List<UserVO> getUserList(CriteriaCH cri) {

        log.info("get List with Criteria: " + cri);

        return mapper.getListWithPaging(cri);
    }

    @Override
    public int getTotal(CriteriaCH cri) {

        log.info("get total count");
        return mapper.getTotalCount(cri);
    }

    @Override
    public UserDetailCheckDTO getUserDetail(int userId) {

        log.info("get User " + userId);
        return mapper.getUserDetail(userId);
    }

    @Override
    public void updateMemo(UserMemoDTO memo) {

        log.info("update Memo " + memo);
        mapper.updateMemo(memo);
    }

    @Override
    public void updateStatus(UserStatusDTO status) {

        log.info("update User Status " + status);
        mapper.updateStatus(status);
    }

}
