package com.ncncn.domain.visit;

import com.ncncn.domain.StatisticsVO;
import com.ncncn.listener.DBConnection;

import javax.naming.NamingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

//Visit 테이블의 DAO
public class VisitCountDAO {

    private static VisitCountDAO instance;

    //싱글톤패턴
    private VisitCountDAO() {
    }

    public static VisitCountDAO getInstance() {

		if (instance == null) {
			instance = new VisitCountDAO();
		}

        return instance;
    }

    //오늘 방문자 수 증가시키기.
    public void setTodayCount() throws SQLException {

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {

            // 쿼리 생성
            // 테이블에 현재 날짜 값을 추가
            StringBuffer sql = new StringBuffer();
            sql.append("INSERT INTO visit (visit_date) VALUES (sysdate())");

            //커넥션을 가져옴.
            conn = DBConnection.getConnection();

            //자동 커밋을 false로 만듬. --> 쿼리가 올바르게 작동 되었을 때만 커밋하기 위해. 실패시 롤백할 것.
            conn.setAutoCommit(false);

            pstmt = conn.prepareStatement(sql.toString());

            //쿼리 실행.
            pstmt.executeUpdate();

            //완료시 커밋.
            conn.commit();

        } catch (SQLException sqle) {

            conn.rollback();

            throw new RuntimeException(sqle.getMessage());

        } catch (Exception e) {

            conn.rollback();

            throw new RuntimeException(e.getMessage());

        } finally {

            // Connection, PreparedStatement를 닫는다.
            try {
                if (pstmt != null) {
                    pstmt.close();
                    pstmt = null;
                }
                if (conn != null) {
                    conn.close();
                    conn = null;
                }
            } catch (Exception e) {
                throw new RuntimeException(e.getMessage());
            }
        }


    } //end setTodayCount()


    //오늘 방문자 수 가져오기.
    public int getTodayCount() {

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

//		StatisticsVO stat = new StatisticsVO();

        int todayCount = 0;

        try {

            StringBuffer sql = new StringBuffer();
            sql.append("SELECT COUNT(*) AS todayCnt FROM visit");
            sql.append(" WHERE date_format(visit_date,'%Y-%m-%d') = curdate();");

            conn = DBConnection.getConnection();

            pstmt = conn.prepareStatement(sql.toString());

            //쿼리 실행
            rs = pstmt.executeQuery();

            //방문자 수 변수에 담기.
            if (rs.next()) {
                todayCount = rs.getInt(1);
//				stat.setVisitrRec(todayCount);
            }

            return todayCount;


        } catch (Exception e) {

            throw new RuntimeException(e.getMessage());

        } finally {

            try {
                if (pstmt != null) {
                    pstmt.close();
                    pstmt = null;
                }
                if (conn != null) {
                    conn.close();
                    conn = null;
                }
            } catch (Exception e) {
                throw new RuntimeException(e.getMessage());
            }

        }


    }

}
