package org.snj.persistence;

import org.snj.domain.CodeVO;

import java.util.*;

public interface CodeDAO {
	public List<CodeVO> retrieveCodeList(Map<String, String> codeParam) throws Exception;
}
