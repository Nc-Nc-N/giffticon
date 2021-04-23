package com.ncncn.service;

import com.ncncn.domain.UserDetailCheckVO;
import com.ncncn.domain.UserMemoVO;
import com.ncncn.domain.UserStatusVO;
import com.ncncn.domain.UserVO;
import com.ncncn.domain.pagination.UserCheckCriteria;
import com.ncncn.mapper.UserMapper;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.java.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Log
public class UserServiceImpl implements UserService {

    @Setter(onMethod_ = @Autowired)
    UserMapper userMapper;

    @Override
    public UserVO readbyId(int userId) {

        UserVO user = userMapper.readById(userId);

        return user;
    }
	@Override
	public int countRecentlyRegister() {
		return userMapper.countRecentlyInsert();
	}


    // 299page
    @Override
    public List<UserVO> getUserList(UserCheckCriteria cri) {

        log.info("get List with Criteria: " + cri);

        return userMapper.getListWithPaging(cri);
    }

    @Override
    public int getTotal(UserCheckCriteria cri) {

        log.info("get total count");
        return userMapper.getTotalCount(cri);
    }

    @Override
    public UserDetailCheckVO getUserDetail(int userId) {

        log.info("get User " + userId);
        return userMapper.getUserDetail(userId);
    }

    @Override
    public void updateMemo(UserMemoVO memo) {

        log.info("update Memo " + memo);
        userMapper.updateMemo(memo);
    }

    @Override
    public void updateStatus(UserStatusVO status) {

        log.info("update User Status " + status);
        userMapper.updateStatus(status);
    }
}
