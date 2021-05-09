package com.ncncn.security;

import com.ncncn.security.domain.CustomUser;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.*;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@Component
@Log4j
public class CustomAuthenticationProvider implements AuthenticationProvider {

    @Setter(onMethod_ = @Autowired)
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Setter(onMethod_ = @Autowired)
    private CustomUserDetailsService customUserDetailsService;

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {

        String email = authentication.getName();
        String password = (String) authentication.getCredentials();

        UserDetails userDetails = customUserDetailsService.loadUserByUsername(email);

        if (userDetails == null) {
            throw new InternalAuthenticationServiceException("User Not Found");
        }

        if (!userDetails.isEnabled()) {
            throw new DisabledException("User disabled");
        }

        if (!passwordChecker(password, userDetails.getPassword(), userDetails.getAuthorities())) {
            throw new BadCredentialsException("비밀번호 오류입니다.");
        }

        UsernamePasswordAuthenticationToken result = new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
        result.setDetails(authentication.getDetails());

        return result;

    }

    @Override
    public boolean supports(Class<?> authentication) {
        return UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication);
    }

    public boolean passwordChecker(String password, String dbPassword, Collection<? extends GrantedAuthority> roleCode) {

        List<String> roleName = new ArrayList<>();

        roleCode.forEach(grantedAuthority -> {
            roleName.add(grantedAuthority.getAuthority());
        });

        if (roleName.contains("사용자(소셜로그인)")) {

            return true;

        } else {
            if (!bCryptPasswordEncoder.matches(password, dbPassword)) {
                return false;
            } else {
                return true;
            }
        }
    }


}
