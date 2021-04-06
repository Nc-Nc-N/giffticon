package com.ncncn.security;

import lombok.extern.log4j.Log4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.rmi.ServerException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@Log4j
public class LoginSuccessHandler implements AuthenticationSuccessHandler {

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
                                        HttpServletResponse response,
                                        Authentication auth)
            throws IOException, ServerException {
        log.warn("Login Success");

        //로그인 대상 권한명 불러오기
        List<String> roleName = new ArrayList<>();
        auth.getAuthorities().forEach(authority -> {
            roleName.add(authority.getAuthority());
        });

        //admin 로그인 시 admin_main으로 리다이렉트
        if (roleName.contains("001")) {
            log.info("role: " + roleName + "admin logined");
            response.sendRedirect("/admin/admin_main");
            return;
        }

        //user 로그인 시 user/home으로 리다이렉트
        if (roleName.contains("000")) {
            log.info("role: " + roleName + "user logined");
            response.sendRedirect("/user/home");
            return;
        }


    }
}
