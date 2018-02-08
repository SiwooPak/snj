package org.snj.persistence;

import java.util.*;

import org.mybatis.spring.SqlSessionTemplate;
import org.snj.domain.BoardVO;
import org.snj.domain.Criteria;
import org.snj.domain.SearchCriteria;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDAOImpl implements BoardDAO {
	//MyBatis 매핑	
	@Autowired
	private SqlSessionTemplate mybatis;

	public void setMybatis(SqlSessionTemplate mybatis) {
		this.mybatis = mybatis;
	}
	
	@Override
	public void create(BoardVO vo) throws Exception {
		mybatis.insert("board.create", vo);
	}

	@Override
	public BoardVO read(Integer bno) throws Exception {
		return mybatis.selectOne("board.read", bno);
	}

	@Override
	public void update(BoardVO vo) throws Exception {
		mybatis.update("board.update", vo);
	}

	@Override
	public void delete(Integer bno) throws Exception {
		mybatis.delete("board.delete", bno);
	}

	@Override
	public List<BoardVO> list(SearchCriteria cri) {
		return mybatis.selectList("board.list", cri);
	}	

	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		return mybatis.selectOne("board.listSearchCount", cri);
	}

	@Override
	public void updateReplyCnt(Integer bno, int amount) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("bno", bno);
		paramMap.put("amount", amount);

		mybatis.update("board.updateReplyCnt", paramMap);
	}

	@Override
	public void updateViewCnt(Integer bno) throws Exception {
		mybatis.update("board.updateViewCnt", bno);
	}

	@Override
	public void addAttach(Map paramMap) throws Exception {
		mybatis.insert("board.addAttach", paramMap);
	}

	@Override
	public List<String> getAttach(Integer bno) throws Exception {
		return mybatis.selectList("board.getAttach", bno);
	}

	@Override
	public void deleteAttach(Integer bno) throws Exception {
		mybatis.delete("board.deleteAttach", bno);
	}

	@Override
	public void replaceAttach(String fullName, Integer bno) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("bno", bno);
		paramMap.put("fullName", fullName);

		mybatis.insert("board.replaceAttach", paramMap);
	}

	@Override
	public List<Map<String, String>> categoryList() throws Exception {
		return mybatis.selectList("board.categoryList");
	}

	@Override
	public List<Map<String, String>> liveList(SearchCriteria cri) throws Exception {
		return mybatis.selectList("board.liveList", cri);
	}

	@Override
	public int listTop(String title) throws Exception {
		return mybatis.selectOne("board.listTop", title);
	}
	
}
