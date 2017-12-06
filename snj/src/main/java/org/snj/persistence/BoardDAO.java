package org.snj.persistence;

import java.util.List;
import java.util.Map;

import org.snj.domain.BoardVO;
import org.snj.domain.Criteria;
import org.snj.domain.SearchCriteria;

public interface BoardDAO {

	// CRUD
	void create(BoardVO vo) throws Exception;
	BoardVO read(Integer bno) throws Exception;
	void update(BoardVO vo) throws Exception;
	void delete(Integer bno) throws Exception;

	// 동적 SQL을 사용한 부분
	List<BoardVO> list(SearchCriteria cri) throws Exception;
	List<Map<String, String>> liveList(SearchCriteria cri) throws Exception;
	int listSearchCount(SearchCriteria cri) throws Exception;
	void updateReplyCnt(Integer bno, int amount) throws Exception;
	void updateViewCnt(Integer bno) throws Exception;

	// 업로드 부분
	void addAttach(Map paramMap) throws Exception;
	List<String> getAttach(Integer bno) throws Exception;
	void deleteAttach(Integer bno) throws Exception;
	void replaceAttach(String fullName, Integer bno) throws Exception;

	List<Map<String, String>> categoryList() throws Exception;
	int listTop(String title) throws Exception;

}