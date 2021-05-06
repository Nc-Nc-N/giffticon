package com.ncncn.service;

import com.ncncn.domain.UserVO;
import com.ncncn.mapper.UserMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;

import org.springframework.security.crypto.password.PasswordEncoder;

import static org.junit.Assert.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@RunWith(MockitoJUnitRunner.class)
public class SignUpServiceTest {

	@Mock
	UserMapper userMapper;

	@Mock
	PasswordEncoder passwordEncoder;

	@InjectMocks
	SignUpServiceImpl signUpService;

	@Test(expected = IllegalArgumentException.class)
	public void registerFailToEmailInvalid() throws Exception {
		UserVO user = new UserVO();
		user.setEmail("aaa");
		user.setPwd("test1234!");
		user.setName("lee hyeji");
		user.setTelNo("01012341234");
		user.setEmlAuthTkn("TeSt1234");

		signUpService.register(user);
	}

	@Test(expected = IllegalArgumentException.class)
	public void registerFailToPwdInvalid1() throws Exception {
		UserVO user = new UserVO();
		user.setEmail("test@ncncn.com");
		user.setPwd("test12");
		user.setName("lee hyeji");
		user.setTelNo("01012341234");
		user.setEmlAuthTkn("TeSt1234");

		signUpService.register(user);
	}

	@Test(expected = IllegalArgumentException.class)
	public void registerFailToPwdInvalid2() throws Exception {
		UserVO user = new UserVO();
		user.setEmail("test@ncncn.com");
		user.setPwd("1234567!");
		user.setName("lee hyeji");
		user.setTelNo("01012341234");
		user.setEmlAuthTkn("TeSt1234");

		signUpService.register(user);
	}

	@Test(expected = IllegalArgumentException.class)
	public void registerFailToNameInvalid1() throws Exception {
		UserVO user = new UserVO();
		user.setEmail("test@ncncn.com");
		user.setPwd("test1234!");
		user.setName("  h");
		user.setTelNo("01012341234");
		user.setEmlAuthTkn("TeSt1234");

		signUpService.register(user);
	}

	@Test(expected = IllegalArgumentException.class)
	public void registerFailToNameInvalid2() throws Exception {
		UserVO user = new UserVO();
		user.setEmail("test@ncncn.com");
		user.setPwd("test1234!");
		user.setName("<p></p>");
		user.setTelNo("01012341234");
		user.setEmlAuthTkn("TeSt1234");

		signUpService.register(user);
	}

	@Test(expected = IllegalArgumentException.class)
	public void registerFailToTelNoInvalid1() throws Exception {
		UserVO user = new UserVO();
		user.setEmail("test@ncncn.com");
		user.setPwd("test12");
		user.setName("lee hyeji");
		user.setTelNo("010-1234-1234");
		user.setEmlAuthTkn("TeSt1234");

		signUpService.register(user);
	}

	@Test(expected = IllegalArgumentException.class)
	public void registerFailToTelNoInvalid2() throws Exception {
		UserVO user = new UserVO();
		user.setEmail("test@ncncn.com");
		user.setPwd("test12");
		user.setName("lee hyeji");
		user.setTelNo("0101231234");
		user.setEmlAuthTkn("TeSt1234");

		signUpService.register(user);
	}

	@Test(expected = IllegalArgumentException.class)
	public void registerFailToAuthTknInvalid() throws Exception {
		UserVO user = new UserVO();
		user.setEmail("test@ncncn.com");
		user.setPwd("test1234!");
		user.setName("lee hyeji");
		user.setTelNo("01012341234");
		user.setEmlAuthTkn("TeS<>@!4");

		signUpService.register(user);
	}

	@Test
	public void registerSuccessTest() throws Exception {
		UserVO user = new UserVO();
		user.setEmail("test@ncncn.com");
		user.setPwd("test1234!");
		user.setName("lee hyeji");
		user.setTelNo("01012341234");
		user.setEmlAuthTkn("token123");

		when(userMapper.insertUser(any())).thenReturn(1);
		when(passwordEncoder.encode(anyString())).thenReturn(anyString());

		int result = signUpService.register(user);

		verify(userMapper).insertUser(user);
		verify(passwordEncoder).encode(anyString());
		assertEquals(1, result);
	}
}