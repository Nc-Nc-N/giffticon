package com.ncncn.service;

import com.ncncn.domain.UserInfoDTO;
import com.ncncn.domain.UserDetailCheckVO;
import com.ncncn.domain.UserVO;
import com.ncncn.domain.pagination.UserCheckCriteria;
import com.ncncn.mapper.SoclInfoMapper;
import com.ncncn.mapper.UserMapper;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.java.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Log
public class UserServiceImpl implements UserService {

    @Setter(onMethod_ = @Autowired)
    UserMapper userMapper;

    @Setter(onMethod_ = @Autowired)
    SoclInfoMapper soclInfoMapper;

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
    public void updateMemo(UserVO memo) {

        log.info("update Memo " + memo);
        userMapper.updateMemo(memo);
    }

    @Transactional
    @Override
    public void updateStatus(UserVO status) {

        log.info("update User Status " + status);
        userMapper.updateStatus(status);

        log.info("record User Status change history");
        userMapper.recordUserStatHistChange(status);
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
    public int updatePwd(String pwd, String email, int userId) {

        //새로 입력된 비밀번호 암호화
        String encodedNewPwd = bCryptPasswordEncoder.encode(pwd);

        int countUpdated = userMapper.updatePwd(encodedNewPwd, email, userId);

        return countUpdated;
    }

    @Override
    public int soclUserReadByEmail(String email, String soclType) {

        UserVO user = userMapper.readUserByEmail(email);

        if (user == null) { //비회원인경우
            log.info("role: X");
            return 0;
        } else {
            if (user.getRoleCode().equals("002")) { //일반회원계정이 있는경우
                log.info("role: 002");
                return 2;
            } else if (user.getRoleCode().equals("003")) { //소셜로그인 계정이 있는경우

                log.info("role: 003");
                String soclTypeinDB = soclInfoMapper.getSocialInfo(user.getId()).getSoclCode();

                if (soclTypeinDB.equals(soclType)) { //소셜로그인 정보 일치하는 경우
                    return 3;
                } else { //소셜로그인 계정이지만 다른 sns로 가입된경우
                    return 4;
                }

            } else { //기타 (관리자인경우)
                log.info("role: 001");
                return 1;
            }

        }
    }

    @Override
    public String checkLoginCode(String email) {

        UserVO user = userMapper.readUserByEmail(email);

        if (user == null) {
            return "none";
        } else if (user.getRoleCode().equals("001") || user.getRoleCode().equals("002")) {
            return "normal";
        } else {
            return "social";
        }
    }

    @Override
    public boolean updateNameAndBirthDt(int userId, UserVO userVO) {

        int isUpdated = userMapper.updateNameAndBirthDt(userId, userVO.getName(), userVO.getBirthDt());

        if (isUpdated == 1) {
            return true;
        } else {
            throw new IllegalArgumentException("변경오류입니다. 관리자에게 문의하세요.");
        }

    }

    @Override
    public boolean updateTelNo(int userId, String telNo){

        int isUpdated = userMapper.updateTelNo(userId, telNo);

        if (isUpdated == 1) {
            return true;
        } else {
            throw new IllegalArgumentException("변경오류입니다. 관리자에게 문의하세요.");
        }
    }

}
