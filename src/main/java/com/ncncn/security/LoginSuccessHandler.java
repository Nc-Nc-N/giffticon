package com.ncncn.security;

import com.ncncn.service.SignUpService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
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

    @Setter(onMethod_ = @Autowired)
    SignUpService signUpService;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
                                        HttpServletResponse response,
                                        Authentication auth)
            throws IOException, ServerException {
        log.warn("로그인 성공....");

        //로그인 이후 이동할 페이지 나눠주기
        String url = redirectUrlSelector(request);

        //쿠키 찾기
        Cookie cookie = CookieFinder(request);
        response.addCookie(cookie);

        //회원 권한 조회
        List<String> roleName = authorityFinder(auth);

        //회원 id는 세션에 저장해놓고 필요할때 꺼내 쓰기
        request.getSession().setAttribute("userId", signUpService.getUserByEmail(auth.getName()).getId());

        //admin 로그인 시 무조건 admin/main으로 리다이렉트
        if (roleName.contains("관리자")) {
            log.info("관리자로 로그인 합니다.");
            response.sendRedirect("/admin/main");
            return;
        }

        log.info("사용자로 로그인 합니다.");

        //user 로그인 시 조건에 따라 이동
        response.sendRedirect(url);
        return;
    }

    //아이디기억 쿠키 찾는 메서드
    public Cookie CookieFinder(HttpServletRequest request) {
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

    //로그인 후 이동할 페이지 선택하는 메서드
    public String redirectUrlSelector(HttpServletRequest request) {

        String redirectUrl;

        SavedRequest requestedUrl = (SavedRequest) request.getSession()
                .getAttribute("SPRING_SECURITY_SAVED_REQUEST");

        //1. 권한이 없어서 security가 로그인창으로 보낸 경우 이후 가려는 페이지로 이동
        if (requestedUrl != null) {
            redirectUrl = requestedUrl.getRedirectUrl();
            request.getSession().removeAttribute("SPRING_SECURITY_SAVED_REQUEST");
            request.getSession().removeAttribute("referer");

        //2. 직접 로그인 창으로 온 경우 이전 페이지로 이동
        } else {
            redirectUrl = (String) request.getSession().getAttribute("referer");
            request.getSession().removeAttribute("referer");
        }

        //3. 처음 왔거나 아이디/비밀번호찾기 , 회원가입 후 로그인할 시 home으로 이동
        if (redirectUrl == null || redirectUrl.contains("/account")) {
            redirectUrl = "/user/home";
        }
        return redirectUrl;
    }

    //회원 권한 조회 메서드
    public List<String> authorityFinder(Authentication auth) {

        List<String> roleName = new ArrayList<>();

        //auth 객체에 담긴 사용자 권한 정보를 roleName List에 담아서 반환
        auth.getAuthorities().forEach(authority -> {
            roleName.add(authority.getAuthority());
        });
        return roleName;
    }
}
