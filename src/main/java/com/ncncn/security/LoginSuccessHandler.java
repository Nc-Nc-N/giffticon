package com.ncncn.security;

import lombok.extern.log4j.Log4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.SavedRequest;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.rmi.ServerException;
import java.util.ArrayList;
import java.util.List;

@Log4j
public class LoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {


    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
                                        HttpServletResponse response,
                                        Authentication auth)
            throws IOException, ServerException {
        log.warn("Login Success Handler");

        //url 저장 값
        String redirectUrl;
        SavedRequest requestedUrl = (SavedRequest) request.getSession()
                .getAttribute("SPRING_SECURITY_SAVED_REQUEST");

        //1. request 된 url을 redirect 주소로 지정
        if (requestedUrl != null) {
            redirectUrl = requestedUrl.getRedirectUrl();
            request.getSession().removeAttribute("SPRING_SECURITY_SAVED_REQUEST");
            request.getSession().removeAttribute("referer");
        } else {
            //2. 없으면 referer를 redirect할 주소로 지정
            redirectUrl = (String) request.getSession().getAttribute("referer");
            request.getSession().removeAttribute("referer");
        }

        String url = urlArranger(redirectUrl);

        Cookie cookie = CookieFinder(request);

        //쿠키값 보내기
        response.addCookie(cookie);

        //로그인 대상 권한명 불러오기
        List<String> roleName = new ArrayList<>();
        auth.getAuthorities().forEach(authority -> {
            roleName.add(authority.getAuthority());
        });

        log.info("role Code: " + roleName + " logined");

        //admin 로그인 시 admin_main으로 리다이렉트
        if (roleName.contains("001")) {

            response.sendRedirect("/admin/admin_main");
            return;
        }

        //user 로그인 시 user/home으로 리다이렉트
        response.sendRedirect(url);
        return;

    }

    //회원가입,pwd email 찾기 후 로그인 시 홈으로 이동
    public String urlArranger(String redirectUrl) {

        if (redirectUrl != null && redirectUrl.contains("/login")) {
            redirectUrl = "/user/home";
        }
        return redirectUrl;
    }
    
    //아이디기억 쿠키 찾는 메서드
    public Cookie CookieFinder(HttpServletRequest request){
        //아이디 기억 쿠키
        String isRemember = request.getParameter("isRemember");
        Cookie cookie = new Cookie("remEmail", request.getParameter("username"));

        if (isRemember != null) {
            cookie.setMaxAge(30 * 24 * 60 * 60);
        } else {
            cookie.setMaxAge(0);
        }

        return cookie;
    }


}
