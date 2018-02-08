package org.snj.service;

import java.util.List;
import java.util.Map;

import org.snj.domain.BoardVO;
import org.snj.domain.Criteria;
import org.snj.domain.SearchCriteria;

//게시판
public interface BoardService {
	void regist(Map map) throws Exception; //등록
	BoardVO read(int bno) throws Exception; //읽기
	void modify(BoardVO dto) throws Exception; //수정
	void remove(Map<String, Comparable> paramMap) throws Exception; //삭제
	int listSearchCount(SearchCriteria cri) throws Exception; //검색 시 게시글 총갯수
	List<String> getAttach(int bno) throws Exception; //게시글의 업로드 파일명
	List<BoardVO> list(SearchCriteria cri) throws Exception;//목록
	List<Map<String, String>> categoryList() throws Exception; //게시글의 종류
	List<Map<String, String>> liveList(SearchCriteria cri) throws Exception; //일본소식통 게시판 목록
}
