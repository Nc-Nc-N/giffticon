package com.ncncn.util;

public class UserValidator {

	public static boolean checkEmail(String email) {
		return email != null && email.matches("^[-_\\.0-9a-zA-Z]*@[0-9a-zA-Z]([-_\\.]?[0-9a-zA-Z])*\\.[a-zA-Z]{2,3}$");
	}

	public static boolean checkPassword(String password) {
		return password != null && password.matches("^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*]).{8,16}$");
	}

	public static boolean checkName(String name) {
		return name != null && name.matches("^[a-zA-Zㄱ-ㅎ가-힣 ]{2,20}$");
	}

	public static boolean checkTelNo(String telNo) {
		return telNo != null && telNo.matches("[0-9]{10,11}$");
	}

	public static boolean checkEmlAuthTkn(String emlAuthTkn) {
		return emlAuthTkn != null && emlAuthTkn.matches("[0-9a-zA-Z]{8}$");
	}

}