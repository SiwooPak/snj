package org.snj.service;
import java.util.*;

import org.snj.domain.CodeVO;

public interface CodeService {
	public List<CodeVO> retrieveCodeList(Map<String, String> codeParam) throws Exception;
}