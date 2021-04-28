package com.ncncn.service;

import com.ncncn.domain.UserInfoDTO;
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
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Log
public class UserServiceImpl implements UserService {

    @Setter(onMethod_ = @Autowired)
    UserMapper userMapper;

    @Setter(onMethod_ = @Autowired)
    BCryptPasswordEncoder bCryptPasswordEncoder;

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
    public List<UserVO> getUserListQuit(UserCheckCriteria cri) {

        log.info("get Quit List with Criteria: " + cri);

        return userMapper.getListWithPagingQuit(cri);
    }

    @Override
    public int getTotal(UserCheckCriteria cri) {

        log.info("get total count");
        return userMapper.getTotalCount(cri);
    }

    @Override
    public int getTotalQuit(UserCheckCriteria cri) {

        log.info("get total quit count");
        return userMapper.getTotalCountQuit(cri);
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

    @Override
    public UserInfoDTO getMyInfo(int userId) {

        log.info("GetMyInfo service of " + userId);

        try {

            UserInfoDTO user = userMapper.getMyInfo(userId);

            return user;

        } catch (Exception e) {

            log.info("해당 사용자 정보가 없습니다.");

            return new UserInfoDTO();

        }
    }

    @Override
    public int updatePwd(String pwd, String email, int userId){

        //새로 입력된 비밀번호 암호화
        String encodedNewPwd = bCryptPasswordEncoder.encode(pwd);

        int countUpdated = userMapper.updatePwd(encodedNewPwd, email, userId);

        return countUpdated;
    }
}
