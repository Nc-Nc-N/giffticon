package com.ncncn.listener;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

	public static Connection dbconn;

	public static Connection getConnection(){

		Connection conn = null;
		try{
			//database 연동
			String user = "root";
			String pw = "ncncn123";
			String url = "jdbc:log4jdbc:mysql://database-1.clkqu9x58whq.ap-northeast-2.rds.amazonaws.com:3306/giffticon";

			Class.forName("net.sf.log4jdbc.sql.jdbcapi.DriverSpy");

			System.out.println("driver load success");

			conn = DriverManager.getConnection(url, user, pw);

			System.out.println("DBConnect success");

		}catch (ClassNotFoundException cnfe){
			System.out.println("DB드라이버 로딩 실패" + cnfe.toString());
		}catch (SQLException sqle){
			System.out.println("DB접속 실패 " + sqle.toString());
		}catch (Exception e){
			System.out.println("예외 발생");
			e.printStackTrace();
		}
		return conn;

	}
}
