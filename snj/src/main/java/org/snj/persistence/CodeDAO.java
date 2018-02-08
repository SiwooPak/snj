package org.snj.persistence;

import org.snj.domain.CodeVO;
import java.util.*;

//게시판
public interface CodeDAO {
	//게시판 카테고리 목록
	public List<CodeVO> retrieveCodeList(Map<String, String> codeParam) throws Exception;
}
