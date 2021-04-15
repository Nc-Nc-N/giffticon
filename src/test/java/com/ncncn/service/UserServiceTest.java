package com.ncncn.service;

import com.ncncn.mapper.UserMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;

import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@RunWith(MockitoJUnitRunner.class)
public class UserServiceTest {

	@InjectMocks
	private UserServiceImpl userService;

	@Mock
	private UserMapper userMapper;

	@Test
	public void countRecentlyRegisterSuccessTest() {
		// userMapper.countRecentlyInsert()의 결과 값으로 0을 반환한다.
		when(userMapper.countRecentlyInsert()).thenReturn(0);

		int count = userService.countRecentlyRegister();

		// userService.countRecentlyRegister() 실행 후 userMapper.countRecentlyInsert()가 호출되었는지 확인
		verify(userMapper).countRecentlyInsert();
		// mapper에서 조회한 값이 변경되지 않고 유지되는지 확인
		assertEquals(0, count);
	}
}
