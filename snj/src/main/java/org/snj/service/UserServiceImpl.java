package org.snj.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.snj.domain.*;
import org.snj.persistence.UserDAO;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserDAO dao;
	
	@Override
	public UserVO login(LoginDTO dto) throws Exception {
		return dao.login(dto);
	}
	
	@Override
	public void keepLogin(String u_id, String sessionId, Date next) throws Exception {
		dao.keepLogin(u_id, sessionId, next);
	}
	
	@Override
	public UserVO checkLoginBefore(String value) throws Exception {
		return dao.checkUserWithSessionKey(value);
	}
	
	@Override
	public UserVO retrieveUser(String id) throws Exception {
		return dao.retrieveUser(id);
	}
	
	@Override
	public UserVO retrieveMail(String email) throws Exception {
		return dao.retrieveMail(email);
	}
	
	@Override
	public void createUser(UserVO vo) throws Exception {
		dao.createUser(vo);
	}
	
	@Override
	public String retrieveUserId(String email) throws Exception {
		return dao.retrieveUserId(email);
	}

	@Override
	public String retrieveUserPw(String id, String email) throws Exception {
		return dao.retrieveUserPw(id,email);
	}

	@Override
	public String getUserGrade(String u_id) throws Exception {
		return dao.getUserGrade(u_id);
	}
	
	@Override
	public List<UserVO> userList(SearchCriteria cri) throws Exception {
		return dao.userList(cri);
	}
	
	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		return dao.totalCount(cri);
	}
	
	@Override
	public void gradeUp(String u_id) throws Exception {
		dao.upgrade(u_id);
	}
	
	@Override
	public void userBye(String u_id) throws Exception {
		dao.bye(u_id);
	}
	
	@Override
	public void updateUser(UserVO vo) throws Exception {
		dao.updateUser(vo);
	}

	@Override
	public Boolean passCheck(Map paramMap) throws Exception {
		return dao.passChk(paramMap);
	}
	
}
