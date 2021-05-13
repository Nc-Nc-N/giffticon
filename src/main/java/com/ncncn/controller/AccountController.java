package com.ncncn.controller;

import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import com.ncncn.domain.UserVO;
import com.ncncn.service.SignUpService;
import com.ncncn.service.SoclInfoService;
import com.ncncn.service.UserService;
import com.ncncn.util.EmailAuthCodeUtils;
import com.ncncn.util.UserAuthCheckUtils;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/account/*")
@Log4j
public class AccountController {


    private final SignUpService signUpService;
    private final JavaMailSender javaMailSender;

    @Setter(onMethod_ = @Autowired)
    UserService userService;

    @Setter(onMethod_ = @Autowired)
    SoclInfoService soclInfoService;

    public AccountController(SignUpService signUpServiceImpl, JavaMailSender javaMailSender) {
        this.signUpService = signUpServiceImpl;
        this.javaMailSender = javaMailSender;
    }

    @GetMapping("/signIn")
    public void signIn(HttpServletRequest request, String error, Model model) {

        model = cookieChecker(request, model);

        //로그인 실패 시
        if (error != null) {
            model.addAttribute("msg", "이메일 또는 비밀번호가 일치하지 않습니다.");
        }

        //직접 logout 해서 로그인 창으로 왔을 시
        if (request.getSession().getAttribute("logout") != null) {
            model.addAttribute("msg", "로그아웃되었습니다.");
            request.getSession().removeAttribute("logout");
        }

        model.addAttribute("soclTypes", soclInfoService.getSoclLoginCode());

        request.getSession().setAttribute("referer", request.getHeader("referer"));
    }

    	@GetMapping("/signUp")
	public String getSignUp() {
		return "/account/signUp";
	}

	// 회원 등록 요청
	@PostMapping(value = "/register", consumes = MediaType.APPLICATION_JSON_VALUE, produces = "application/text; charset=UTF-8")
	public ResponseEntity<String> register(@RequestBody UserVO user) {
		try {
			// 사용자 등록
			int result = signUpService.register(user);
		} catch (Exception e) {
			// 등록 실패사유를 응답에 담아 전송
			return new ResponseEntity<>(e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return new ResponseEntity<>("success", HttpStatus.OK);
	}

	// 이메일 중복확인
	@GetMapping(value = "/checkExists", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Boolean> checkExists(@RequestParam("email") String email) {
		boolean isExists = false;
		try {
			isExists = signUpService.isEmailExists(email);
		} catch (Exception e) {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return new ResponseEntity<>(isExists, HttpStatus.OK);
	}

	// 사용자가 입력한 이메일로 인증메일 전송
	@GetMapping(value = "/emailConfirm", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Map<String, String>> confirmEmail(@RequestParam("email") String email) {
		Map<String, String> map = new HashMap<>();

		String code = EmailAuthCodeUtils.getAuthCode();         // 인증코드 생성
		SimpleMailMessage message = new SimpleMailMessage();

		try {
			message.setTo(email);
			message.setSubject("기쁘티콘 회원가입 이메일 인증");
			message.setText("인증 코드: " + code);

			javaMailSender.send(message);           // 생성한 메일 전송
		} catch (Exception e) {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}

		map.put("code", code);                      // 인증메일 전송에 성공하면 map에 인증코드를 담아 전달
		return new ResponseEntity<>(map, HttpStatus.OK);
	}

    public Model cookieChecker(HttpServletRequest request, Model model) {

        Cookie[] cookies = request.getCookies();

        if (cookies != null) {
            for (int i = 0; i < cookies.length; i++) {
                if (cookies[i].getName().equals("remEmail")) {
                    model.addAttribute("email", cookies[i].getValue());
                    model.addAttribute("isRemember", "checked");
                }
            }
        }
        return model;
    }

    @GetMapping(value = "/socialAccountCheck")
    public ResponseEntity<Integer> socialAccountCheck(@RequestParam("email") String email,
                                                      @RequestParam("soclType") String soclType) {

        //회원 상태에 따라 0,1,2,3 반환
        try {
            int isRegistered = userService.soclUserReadByEmail(email, soclType);
            log.info("isRegistered :" + isRegistered);
            return new ResponseEntity<Integer>(isRegistered, HttpStatus.OK);
        } catch (Exception e) {
            log.info("social check error");
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }


    }

    @GetMapping(value = "/basicAccountCheck")
    public ResponseEntity<String> ajaxLogin(@RequestParam("email") String email) {

        try {
            String usertype = userService.checkLoginCode(email);
            return new ResponseEntity<String>(usertype, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping(value ="/socialSignUp")
    public void socialSignUp(String email, String name, String soclTypeCode, Model model){


        model.addAttribute("email", email);
        model.addAttribute("name", name);
        model.addAttribute("soclTypeCode", soclTypeCode);

    }

    @GetMapping(value="/socialAccLink")
    public void socialAccLink(String email, String name, String soclTypeCode, Model model){

        UserVO user = signUpService.getUserByEmail(email);

        model.addAttribute("user", user);
        model.addAttribute("soclEmail", email);
        model.addAttribute("soclName", name);
        model.addAttribute("soclTypeCode", soclTypeCode);

    }

    // 소셜 회원 등록 요청
    @PostMapping(value = "/soclRegister", consumes = MediaType.APPLICATION_JSON_VALUE, produces = "application/text; charset=UTF-8")
    public ResponseEntity<String> soclRegister(@RequestBody UserVO user) {

        String soclType = user.getRoleCode();
        user.setRoleCode("003");
        try {
            // 사용자 등록
            signUpService.register(user);

            int userId = signUpService.getUserByEmail(user.getEmail()).getId();

            soclInfoService.RegisterSoclUser(userId,soclType);

        } catch (Exception e) {
            // 등록 실패사유를 응답에 담아 전송
            return new ResponseEntity<>(e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }

        return new ResponseEntity<>("success", HttpStatus.OK);
    }

    @RequestMapping(value = "/soclCheckOriPwd",
            method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<String> soclCheckOriPwd(@RequestParam Map<String, String> checkUser) {

        String email = checkUser.get("email");
        String pwd = checkUser.get("pwd");
        String soclType = checkUser.get("soclType");
        String name = checkUser.get("name");
        int userId = Integer.parseInt(checkUser.get("userId"));

        UserVO user = signUpService.getUserByEmail(email);

        //입력된 비밀번호가 db값과 일치여부 확인
        if (UserAuthCheckUtils.userAuthCheck(email, pwd, user)) {

            boolean isUpdated = soclInfoService.changeUserAsSocl("사용자(소셜로그인)",name, email);
            boolean isRegistered = soclInfoService.RegisterSoclUser(userId, soclType);

            if(isUpdated == true && isRegistered && true){

                return new ResponseEntity<>(HttpStatus.OK);
            }else{
                return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
            }

        } else {

            return new ResponseEntity<>(HttpStatus.NOT_ACCEPTABLE);
        }
    }

}
