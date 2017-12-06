package org.snj.util;

import org.snj.persistence.UserDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class Schedular {
	@Autowired
	private UserDAO userDAO;
	//매주 월요일마다 일정 포인트 이상인 준회원인 경우 정회원으로 등급 업
	@Scheduled(cron = "0 0 9 ? * MON")
	public void gradeUp() throws Exception {
		userDAO.upGradeSchedular();
	}
}
