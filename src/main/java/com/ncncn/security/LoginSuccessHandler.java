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
        log.warn("Login Success Handler....");

        String url = redirectUrlSelector(request);
        Cookie cookie = CookieFinder(request);
        List<String> roleName = authorityFinder(auth);

        response.addCookie(cookie);

        request.getSession().setAttribute("userId", signUpService.getByEmail(auth.getName()).getId());


        //admin 로그인 시 admin/main으로 리다이렉트
        if (roleName.contains("관리자")) {
            log.info("관리자로 로그인 합니다.");
            response.sendRedirect("/admin/main");
            return;
        }

        log.info("사용자로 로그인 합니다.");
        //user 로그인 시 user/home으로 리다이렉트
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

        if (requestedUrl != null) {
            redirectUrl = requestedUrl.getRedirectUrl();
            request.getSession().removeAttribute("SPRING_SECURITY_SAVED_REQUEST");
            request.getSession().removeAttribute("referer");
        } else {
            //2. 없으면 referer를 redirect할 주소로 지정
            redirectUrl = (String) request.getSession().getAttribute("referer");
            request.getSession().removeAttribute("referer");
        }

        if (redirectUrl == null || redirectUrl.contains("/account")) {
            redirectUrl = "/user/home";
        }
        return redirectUrl;
    }

    //회원 권한 조회 메서드
    public List<String> authorityFinder(Authentication auth) {

        List<String> roleName = new ArrayList<>();
        log.info("auth 정보: " + auth.toString());
        auth.getAuthorities().forEach(authority -> {
            roleName.add(authority.getAuthority());
        });
        return roleName;
    }
}
