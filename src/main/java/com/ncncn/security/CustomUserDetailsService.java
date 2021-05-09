package com.ncncn.security;

import com.ncncn.domain.UserVO;
import com.ncncn.mapper.UserMapper;
import com.ncncn.security.domain.CustomUser;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

@Log4j
public class CustomUserDetailsService implements UserDetailsService {

    @Setter(onMethod_ = @Autowired)
    private UserMapper usermapper;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {

        UserVO vo = usermapper.readForLogin(email);

        //나중에 소셜로그인 회원가입 받을 때 null 아닌 "" 처리로 변경 후 삭제
        try {
            if (vo.getPwd() == null) {
                vo.setPwd("");
            }
        } catch (NullPointerException e) {

        }
        //db에서 email로 사용자 정보를 불러오고, 해당 사용자를 customUser 객체에 담아서 반환
        return vo == null ? null : new CustomUser(vo);
    }


}
