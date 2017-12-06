package org.snj.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.snj.domain.LoginDTO;
import org.snj.domain.SearchCriteria;
import org.snj.domain.UserVO;

public interface UserService {
	//로그인
	UserVO login(LoginDTO dto) throws Exception;
	//로그인 세션 유지
	void keepLogin(String u_id, String sessionId, Date next) throws Exception;
	//로그인 유무
	UserVO checkLoginBefore(String value) throws Exception;
	//회원개인 정보 및 ID 체크
	UserVO retrieveUser(String id) throws Exception;
	//회원가입시 이메일 체크
	UserVO retrieveMail(String email) throws Exception;
	//회원가입
	void createUser(UserVO vo) throws Exception;
	//비밀번호 찾기
	String retrieveUserPw(String id, String email) throws Exception;
	//아이디 찾기
	String retrieveUserId(String email) throws Exception;
	//회원목록
	List<UserVO> userList(SearchCriteria cri) throws Exception;
	//페이징 처리를 위한 총갯수
	int listSearchCount(SearchCriteria cri) throws Exception;
	//회원 등급
	String getUserGrade(String u_id) throws Exception;
	//등업
	void gradeUp(String u_id) throws Exception;
	//탈퇴
	void userBye(String u_id) throws Exception;
	//회원정보수정
	void updateUser(UserVO vo) throws Exception;
	//비밀번호확인
	Boolean passCheck(Map paramMap) throws Exception;
}
