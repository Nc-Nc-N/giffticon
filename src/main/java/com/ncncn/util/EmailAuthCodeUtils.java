package com.ncncn.util;

import java.math.MathContext;

public class EmailAuthCodeUtils {

	private static final int CODE_LENGTH = 8;

	private static final int RANDOM_RANGE = 26;

	public static String getAuthCode() {
		StringBuilder code = new StringBuilder();

		for (int i = 0; i < CODE_LENGTH; ++i) {
			int n = (int) (Math.random() * 3);
			code.append(getChar(n));
		}

		return code.toString();
	}

	private static String getChar(int n) {
		String s = "";

		switch (n) {
			case 0: s = String.valueOf((char)((int)(Math.random() * RANDOM_RANGE) + 'a'));
					break;
			case 1: s = String.valueOf((char)((int)(Math.random() * RANDOM_RANGE) + 'A'));
					break;
			case 2: s = String.valueOf((int)(Math.random() * 10));
					break;
		}

		return s;
	}

	public static void main(String[] args) {
		System.out.println(getAuthCode());

	}

}
