package com.ncncn.util;

import java.util.UUID;

public class EmailAuthCodeUtils {

	private static final int CODE_LENGTH = 8;

	public static String getAuthCode() {
		String uuid = UUID.randomUUID().toString();
		return uuid.replaceAll("-", "").substring(0, CODE_LENGTH);
	}

}
