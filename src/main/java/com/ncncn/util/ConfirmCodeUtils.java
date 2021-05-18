package com.ncncn.util;

import java.util.UUID;

public class ConfirmCodeUtils {

	private static final int CODE_LENGTH = 8;

	public static String getCode() {
		String uuid = UUID.randomUUID().toString();
		return uuid.replaceAll("-", "").substring(0, CODE_LENGTH);
	}

}
