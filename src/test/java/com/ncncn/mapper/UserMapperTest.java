package com.ncncn.mapper;

import com.ncncn.domain.UserVO;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.assertEquals;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/applicationContext.xml")
@Log4j
public class UserMapperTest {

	@Autowired
	private UserMapper userMapper;

	@Test
	public void registerAndFindUserByEmailTest() {
		UserVO user = new UserVO();
		user.setEmail("registerTest@test.com");
		user.setName("test");
		user.setPwd("test1234");
		user.setTelNo("010-1234-5678");

		int result = userMapper.insert(user);

		UserVO findUser = userMapper.readByEmail(user.getEmail());

		assertEquals(1, result);
		assertEquals(user.getEmail(), findUser.getEmail());
		assertEquals(user.getPwd(), findUser.getPwd());
		assertEquals(user.getName(), findUser.getName());

		userMapper.deleteByEmail(user.getEmail());
	}

	@Test
	public void deleteByEmailTest() {
		UserVO user = new UserVO();
		user.setEmail("deleteTest@test.com");
		user.setName("test");
		user.setPwd("test1234");
		user.setTelNo("010-1234-5678");

		userMapper.insert(user);

		int result = userMapper.deleteByEmail(user.getEmail());

		assertEquals(1, result);
	}
}
