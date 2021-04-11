package com.ncncn.service;

import com.ncncn.domain.*;
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

//    @Override
//    public List<UserVO> getUserList(){
//        log.info("getUserList...........");
//        return mapper.getUserList();
//    }

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
//        UserDetailCheckDTO dto = mapper.getUserDetail(userId);
//        mapper.getPoint();
//        mapper.getAccount(); 이런식으로 다 불러와서 userDetailCheckDTO에 합칠 것

        UserDetailCheckDTOsub1 dto1 = getUserDetailSub1(userId);
        UserDetailCheckDTOsub2 dto2 = getUserDetailSub2(userId);
        UserDetailCheckDTOsub3 dto3 = getUserDetailSub3(userId);
        UserDetailCheckDTOsub4 dto4 = getUserDetailSub4(userId);
        UserDetailCheckDTOsub5 dto5 = getUserDetailSub5(userId);

        return new UserDetailCheckDTO(dto1, dto2, dto3, dto4, dto5);
    }

    @Override
    public UserDetailCheckDTOsub1 getUserDetailSub1(int userId) {
        return mapper.getUserDetailSub1(userId);
    }

    @Override
    public UserDetailCheckDTOsub2 getUserDetailSub2(int userId) {
       if(mapper.getUserDetailSub2(userId) == null) {
           return new UserDetailCheckDTOsub2();
       } else {
           return mapper.getUserDetailSub2(userId);
       }
    }

    @Override
    public UserDetailCheckDTOsub3 getUserDetailSub3(int userId) {
        if(mapper.getUserDetailSub3(userId) == null) {
            return new UserDetailCheckDTOsub3();
        } else {
            return mapper.getUserDetailSub3(userId);
        }

    }

    @Override
    public UserDetailCheckDTOsub4 getUserDetailSub4(int userId) {
        if(mapper.getUserDetailSub4(userId) == null) {
            return new UserDetailCheckDTOsub4();
        } else {
            return mapper.getUserDetailSub4(userId);
        }

    }

    @Override
    public UserDetailCheckDTOsub5 getUserDetailSub5(int userId) {
        return mapper.getUserDetailSub5(userId);
    }


    @Override
    public void updateMemo(UserMemoDTO memo) {

        log.info("update Memo " + memo);
        mapper.updateMemo(memo);
    }



}
