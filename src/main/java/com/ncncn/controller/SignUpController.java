package com.ncncn.controller;

import java.util.HashMap;
import java.util.Map;

import com.ncncn.domain.UserVO;
import com.ncncn.service.SignUpServiceImpl;
import com.ncncn.util.EmailAuthCodeUtils;
import lombok.extern.log4j.Log4j;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/account/*")
@Log4j
public class SignUpController {

	private final SignUpServiceImpl signUpServiceImpl;
	private final JavaMailSender javaMailSender;

	public SignUpController(SignUpServiceImpl signUpServiceImpl, JavaMailSender javaMailSender) {
		this.signUpServiceImpl = signUpServiceImpl;
		this.javaMailSender = javaMailSender;
	}

	@GetMapping("/signUp")
	public String getSignUp() {
		return "/account/signUp";
	}

	@PostMapping(value = "/register", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> register(@RequestBody UserVO user) {
		log.info("UserVO: " + user);

		try {
			int result = signUpServiceImpl.register(user);
		} catch (Exception e) {
			return new ResponseEntity<>(e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return new ResponseEntity<>("success", HttpStatus.OK);
	}

	@GetMapping(value = "/checkExists", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Integer> getUser(@RequestParam("email") String email) {
		int isExists = 0;

		try {
			UserVO userVO = signUpServiceImpl.getByEmail(email);
			isExists = 1;
		} catch (Exception e) {
			log.info("존재하지 않는 사용자 이메일입니다.");
		}

		return isExists == 1 ? new ResponseEntity<>(isExists, HttpStatus.OK)
				: new ResponseEntity<>(isExists, HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@GetMapping(value = "/emailConfirm", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Map<String, String>> confirmEmail(@RequestParam("email") String email) {
		Map<String, String> map = new HashMap<>();

		String code = EmailAuthCodeUtils.getAuthCode();

		SimpleMailMessage message = new SimpleMailMessage();

		try {
			message.setTo(email);

			message.setSubject("기쁘티콘 회원가입 이메일 인증");
			message.setText("인증 코드: " + code);

			javaMailSender.send(message);
		} catch (Exception e) {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}

		map.put("code", code);

		return new ResponseEntity<>(map, HttpStatus.OK);
	}
}
