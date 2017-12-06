package org.snj.persistence;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.snj.domain.UserVO;
import org.snj.domain.LoginDTO;
import org.snj.domain.SearchCriteria;

public interface UserDAO {

	UserVO login(LoginDTO dto)throws Exception;
	void keepLogin(String uid, String sessionId, Date next) throws Exception;
	UserVO checkUserWithSessionKey(String value) throws Exception;	
	UserVO retrieveUser(String id) throws Exception;
	void createUser(UserVO vo) throws Exception;
	void updateUser(UserVO vo) throws Exception;
	UserVO retrieveMail(String email) throws Exception;
	String retrieveUserPw(String id, String email) throws Exception;
	List<UserVO> userList(SearchCriteria cri) throws Exception;
	int totalCount(SearchCriteria cri) throws Exception;
	String getUserGrade(String u_id) throws Exception;
	void upgrade(String u_id) throws Exception;  
	void bye(String u_id) throws Exception;
	//일주일마다 일정 포인트 이상인 경우 등급 업 
	void upGradeSchedular() throws Exception;
	String retrieveUserId(String email) throws Exception;
	Boolean passChk(Map paramMap) throws Exception;
}
