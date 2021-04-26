package com.ncncn.security;

import lombok.extern.log4j.Log4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Log4j
public class LogOutSuccessHandler implements LogoutSuccessHandler {

    @Override
    public void onLogoutSuccess(HttpServletRequest request,
                                HttpServletResponse response,
                                Authentication authentication)
            throws IOException, ServletException {

        //권한 정보가 있을 경우 (로그인 한 경우)
        if (authentication != null && authentication.getDetails() != null) {
            try {
                //세션 삭제
                request.getSession().invalidate();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        log.info("로그아웃되었습니다.");
        response.setStatus(HttpServletResponse.SC_OK);

        //로그아웃 메세지 띄우기용으로 저장
        request.getSession().setAttribute("logout", "logout");

        //로그아웃하면 로그인창으로 보냄
        response.sendRedirect("/account/signIn");
    }
}
