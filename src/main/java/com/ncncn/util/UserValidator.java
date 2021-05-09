package com.ncncn.util;

public class UserValidator {

	public static boolean checkEmail(String email) {
		// test@test.com 또는 test@test.kr과 같은 이메일 형식과 일치하는지 확인
		return email != null && email.matches("^[-_\\.0-9a-zA-Z]*@[0-9a-zA-Z]([-_\\.]?[0-9a-zA-Z])*\\.[a-zA-Z]{2,3}$");
	}

	public static boolean checkPassword(String password) {
		// 길이가 8이상 16이하이고, 영문, 숫자, 특수문자를 모두 포함하는지 확인
		return password != null && password.matches("^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*]).{8,16}$");
	}

	public static boolean checkName(String name) {
		// 길이가 2이상 20이하이고, 영문 또는 한글로 이루어져있는지 확인
		return name != null && name.matches("^[a-zA-Zㄱ-ㅎ가-힣 ]{2,20}$");
	}

	public static boolean checkTelNo(String telNo) {
		// 길이가 11자리이고, 숫자로만 이루어져있는지 확인
		return telNo != null && telNo.matches("[0-9]{11}$");
	}

	public static boolean checkEmlAuthTkn(String emlAuthTkn) {
		// 길이가 8자리이고, 숫자, 영문으로만 이루어져있는지 확인
		return emlAuthTkn != null && emlAuthTkn.matches("[0-9a-z]{8}$");
	}

}