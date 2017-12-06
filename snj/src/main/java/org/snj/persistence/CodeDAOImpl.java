package org.snj.persistence;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.snj.domain.CodeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CodeDAOImpl implements CodeDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public void setMybatis(SqlSessionTemplate mybatis) {
		this.mybatis = mybatis;
	}
	
	@Override
	public List<CodeVO> retrieveCodeList(Map<String, String> codeParam) throws Exception {
		return mybatis.selectList("code.retrieveCodeList", codeParam);
	}

}
