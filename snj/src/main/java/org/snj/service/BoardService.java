package org.snj.service;

import java.util.List;
import java.util.Map;

import org.snj.domain.BoardVO;
import org.snj.domain.Criteria;
import org.snj.domain.SearchCriteria;

public interface BoardService {
	void regist(Map map) throws Exception;
	BoardVO read(int bno) throws Exception;
	void modify(BoardVO dto) throws Exception;
	void remove(Map<String, Comparable> paramMap) throws Exception;
	int listSearchCount(SearchCriteria cri) throws Exception;
	List<String> getAttach(int bno) throws Exception;
	List<BoardVO> list(SearchCriteria cri) throws Exception;
	List<Map<String, String>> categoryList() throws Exception;
	List<Map<String, String>> liveList(SearchCriteria cri) throws Exception;
}
