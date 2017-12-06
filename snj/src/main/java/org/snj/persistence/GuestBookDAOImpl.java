package org.snj.persistence;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.snj.domain.SearchCriteria;
import org.snj.domain.UserVO;
import org.snj.domain.GuestBookVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class GuestBookDAOImpl implements GuestBookDAO {
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public void setMybatis(SqlSessionTemplate mybatis) {
		this.mybatis = mybatis;
	}

	@Override
	public List<GuestBookVO> listCriteria(SearchCriteria cri) {
		return mybatis.selectList("gbook.listCriteria", cri);
	}
    
	@Override
	public int totalCount(SearchCriteria cri) throws Exception {
		return mybatis.selectOne("gbook.total", cri);
	}

	@Override
	public void createGuest(GuestBookVO vo) throws Exception {
		mybatis.insert("gbook.createGuest", vo);
	}
	
	@Override
	public void createMember(GuestBookVO vo) throws Exception {
		mybatis.insert("gbook.createMember", vo);
	}

	@Override
	public boolean delete(Integer gbno) throws Exception {
		return mybatis.delete("gbook.delete", gbno)>0;
	}

	@Override
	public boolean passCheck(Map map) throws Exception {
		boolean flag = false;
		flag = mybatis.selectOne("gbook.passCheck", map);
		System.out.println("DAO에서의 flag 값: "+flag);
		return flag;
	}

	@Override
	public void upAnsnum(Integer grpno) throws Exception {
		mybatis.update("gbook.upAnsnum", grpno);
	}

	@Override
	public void commentMember(GuestBookVO vo) throws Exception {
		mybatis.insert("gbook.commentMember", vo);
	}

	@Override
	public void commentGuest(GuestBookVO vo) throws Exception {
		mybatis.insert("gbook.commentGuest", vo);
	}

	@Override
	public int getGrpno(Integer gbno) throws Exception {
		return mybatis.selectOne("gbook.getGrpno", gbno);
	}

	@Override
	public void upCommentCount(Integer grpno) throws Exception {
		mybatis.update("gbook.upCommentCount", grpno);
	}

	@Override
	public GuestBookVO commentRead(int gbno) throws Exception {
		return mybatis.selectOne("gbook.commentRead", gbno);
	}

	@Override
	public void updateComment(Map paramMap) throws Exception {
		mybatis.update("gbook.updateComment", paramMap);
	}

	@Override
	public void setIndex() throws Exception {
		mybatis.update("gbook.setIndex");	
	}
	
	@Override
	public void zeroIndex() throws Exception {
		mybatis.update("gbook.zeroIndex");	
	}
}
