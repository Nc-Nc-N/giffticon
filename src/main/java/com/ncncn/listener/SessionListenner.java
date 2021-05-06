package com.ncncn.listener;

import com.ncncn.domain.visit.VisitCountDAO;
import lombok.extern.log4j.Log4j;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;


//web.xml에 listener등록 --> 톰켓이 실행되면서 리스너가 실행됌.
@Log4j
public class SessionListenner implements HttpSessionListener {

	@Override
	public void sessionCreated(HttpSessionEvent httpSessionEvent) {

		//세션이 새로 생성되면 execute()를 실행
		if(httpSessionEvent.getSession().isNew()){
			execute(httpSessionEvent);
		}
	}

	private void execute(HttpSessionEvent sessionEvent) {

		log.info("새로운 세션 생성");

		VisitCountDAO dao = VisitCountDAO.getInstance();

		try{
			//오늘 방문자 수 증가.
			dao.setTodayCount();

			//오늘 방문자 수
			int todayCount = dao.getTodayCount();
			log.info("오늘 방문자 수 :" + todayCount);
			HttpSession session = sessionEvent.getSession();

			//세션에 방문자 수 담기.
			session.setAttribute("todayCount", todayCount);

		}catch (Exception e){
			System.out.println("===== 방문자 카운터 오류 =====\n");
			e.printStackTrace();
		}

	}

	@Override
	public void sessionDestroyed(HttpSessionEvent httpSessionEvent) {

		log.info("sessionDestroyed");
	}
}
