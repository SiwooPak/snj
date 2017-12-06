package org.snj.service;

import java.util.List;
import java.util.Map;

import org.snj.domain.CodeVO;
import org.snj.persistence.CodeDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CodeServiceImpl implements CodeService {
	
	@Autowired
	private CodeDAO dao;
	
	@Override
	public List<CodeVO> retrieveCodeList(Map<String, String> codeParam) throws Exception {
		return dao.retrieveCodeList(codeParam);
	}

}
