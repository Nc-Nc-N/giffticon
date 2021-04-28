package com.ncncn.security;

import lombok.extern.log4j.Log4j;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Log4j
public class CustomAccessDeniedHandler implements AccessDeniedHandler {

    @Override
    public void handle(HttpServletRequest request,
                       HttpServletResponse response,
                       AccessDeniedException accessException)
            throws IOException, ServletException {

        log.error("접근이 거부되었습니다.");

        //접근 거부 시 로그인 페이지로 이동
        response.sendRedirect("/account/signIn");

    }
}
