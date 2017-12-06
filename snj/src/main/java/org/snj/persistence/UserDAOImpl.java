package org.snj.persistence;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.snj.domain.UserVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.snj.domain.LoginDTO;
import org.snj.domain.SearchCriteria;

@Repository
public class UserDAOImpl implements UserDAO {

	@Autowired
	private SqlSessionTemplate mybatis;

	public void setMybatis(SqlSessionTemplate mybatis) {
		this.mybatis = mybatis;
	}

	@Override
	public UserVO login(LoginDTO dto) throws Exception {

		return mybatis.selectOne("user.login", dto);
	}

	@Override
	public void keepLogin(String uid, String mybatisId, Date next) {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("uid", uid);
		paramMap.put("mybatisId", mybatisId);
		paramMap.put("next", next);

		mybatis.update("user.keepLogin", paramMap);

	}

	@Override
	public UserVO checkUserWithSessionKey(String value) {
		return mybatis.selectOne("user.checkUserWithSessionKey", value);
	}
	
	@Override
	public UserVO retrieveUser(String id)  {
		return mybatis.selectOne("user.retrieveUser", id);
	}

	@Override
	public UserVO retrieveMail(String email) {
		return mybatis.selectOne("user.retrieveMail", email);
	}

	@Override
	public void createUser(UserVO vo) {
		mybatis.insert("user.createUser", vo);
	}

	@Override
	public void updateUser(UserVO vo) throws Exception {
		mybatis.update("user.updateUser", vo);
	}
	
	@Override
	public String retrieveUserId(String email) throws Exception {
		return mybatis.selectOne("user.retrieveUserId", email);
	}

	@Override
	public String retrieveUserPw(String id, String email) {
		HashMap<String, String> pass = new HashMap<String, String>();
		pass.put("id", id);
		pass.put("email", email);
		return mybatis.selectOne("user.retrieveUserPw", pass);
	}
	
	@Override
	public String getUserGrade(String u_id) throws Exception {
		return mybatis.selectOne("user.getGrade", u_id);
	}

	@Override
	public List<UserVO> userList(SearchCriteria cri) throws Exception {
		return mybatis.selectList("user.userList", cri);
	}

	@Override
	public int totalCount(SearchCriteria cri) throws Exception {
		return mybatis.selectOne("user.totalCount", cri);
	}

	@Override
	public void upgrade(String u_id) throws Exception {
		mybatis.update("user.upgrade", u_id);
	}

	@Override
	public void bye(String u_id) throws Exception {
		mybatis.delete("user.bye", u_id);
	}

	@Override
	public void upGradeSchedular() throws Exception {
		mybatis.update("user.upSchedular");
	}

	@Override
	public Boolean passChk(Map paramMap) throws Exception {
		return mybatis.selectOne("user.passChk", paramMap);
	}
	
}