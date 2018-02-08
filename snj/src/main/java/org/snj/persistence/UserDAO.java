package org.snj.persistence;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.snj.domain.UserVO;
import org.snj.domain.LoginDTO;
import org.snj.domain.SearchCriteria;

//회원
public interface UserDAO {

	UserVO login(LoginDTO dto)throws Exception; //로그인
	void keepLogin(String uid, String sessionId, Date next) throws Exception; //로그인 유지
	UserVO checkUserWithSessionKey(String value) throws Exception;	//로그인 세션 확인
	UserVO retrieveUser(String id) throws Exception; //중복된 아이디 확인
	void createUser(UserVO vo) throws Exception; // 회원가입
	void updateUser(UserVO vo) throws Exception; // 회원정보 수정
	UserVO retrieveMail(String email) throws Exception; //중복된 메일확인
	String retrieveUserPw(String id, String email) throws Exception; //비밀번호 찾기
	List<UserVO> userList(SearchCriteria cri) throws Exception; //회원목록
	int totalCount(SearchCriteria cri) throws Exception; //총회원수
	String getUserGrade(String u_id) throws Exception; //회원등급
	void upgrade(String u_id) throws Exception;  //회원등업 
	void bye(String u_id) throws Exception; //회원추방
	//일주일마다 일정 포인트 이상인 경우 등급 업 
	void upGradeSchedular() throws Exception; //자동 드업
	String retrieveUserId(String email) throws Exception; //아이디 찾기
	Boolean passChk(Map paramMap) throws Exception; //로그인시 비밀번호 확인
}
