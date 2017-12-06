package org.snj.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.snj.domain.Criteria;
import org.snj.domain.ReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO {

	@Autowired
	private SqlSessionTemplate mybatis;

	public void setMybatis(SqlSessionTemplate mybatis) {
		this.mybatis = mybatis;
	}

	@Override
	public List<ReplyVO> list(Integer bno) throws Exception {

		return mybatis.selectList("reply.list", bno);
	}

	@Override
	public void create(ReplyVO vo) throws Exception {

		mybatis.insert("reply.create", vo);
	}

	@Override
	public void update(ReplyVO vo) throws Exception {

		mybatis.update("reply.update", vo);
	}

	@Override
	public void delete(Integer rno) throws Exception {

		mybatis.update("reply.delete", rno);
	}

	@Override
	public List<ReplyVO> listPage(Integer bno, Criteria cri) throws Exception {

		Map<String, Object> paramMap = new HashMap<>();

		paramMap.put("bno", bno);
		paramMap.put("cri", cri);

		return mybatis.selectList("reply.listPage", paramMap);
	}

	@Override
	public int count(Integer bno) throws Exception {

		return mybatis.selectOne("reply.count", bno);

	}

	@Override
	public int getBno(Integer rno) throws Exception {

		return mybatis.selectOne("reply.getBno", rno);
	}
	
	@Override
	public String getRwriter(Integer rno) throws Exception {

		return mybatis.selectOne("reply.getRwriter", rno);
	}

}