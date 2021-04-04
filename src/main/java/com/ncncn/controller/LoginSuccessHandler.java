package com.ncncn.controller;

import lombok.extern.log4j.Log4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.rmi.ServerException;
import java.util.Collection;

@Log4j
public class LoginSuccessHandler implements AuthenticationSuccessHandler {

        @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
                                        HttpServletResponse response,
                                        Authentication auth)
                                        throws IOException, ServerException {
            log.warn("Login Success");

            Collection<? extends GrantedAuthority> roleName = auth.getAuthorities();

            if(roleName.contains("ROLE_ADMIN")){
                response.sendRedirect("/admin/main");
                return;
            }


            response.sendRedirect("/user/main");
    }
}
