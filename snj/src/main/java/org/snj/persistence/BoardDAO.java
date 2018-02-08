package org.snj.persistence;

import java.util.List;
import java.util.Map;

import org.snj.domain.BoardVO;
import org.snj.domain.Criteria;
import org.snj.domain.SearchCriteria;

public interface BoardDAO {

	// CRUD
	void create(BoardVO vo) throws Exception; //게시글 등록
	BoardVO read(Integer bno) throws Exception; //게시글 읽기
	void update(BoardVO vo) throws Exception; //게시글 수정
	void delete(Integer bno) throws Exception; //게시글 삭제

	// 동적 SQL을 사용한 부분
	List<BoardVO> list(SearchCriteria cri) throws Exception; //게시판 목록
	List<Map<String, String>> liveList(SearchCriteria cri) throws Exception;//일본소식통 게시글 목록
	int listSearchCount(SearchCriteria cri) throws Exception; //게시글의 총갯수
	void updateReplyCnt(Integer bno, int amount) throws Exception; //댓글수 수정
	void updateViewCnt(Integer bno) throws Exception; //조회수 수정

	// 업로드 부분
	void addAttach(Map paramMap) throws Exception; //게시글에 업로드할 파일이 있을시 업로드 파일 등록
	List<String> getAttach(Integer bno) throws Exception; //업로드 파일 가져오기
	void deleteAttach(Integer bno) throws Exception; //업로드 파일 삭제
	void replaceAttach(String fullName, Integer bno) throws Exception;//업로드 파일 변경

	List<Map<String, String>> categoryList() throws Exception; //게시판 종류 목록
	int listTop(String title) throws Exception; //카테고리 지정

}
