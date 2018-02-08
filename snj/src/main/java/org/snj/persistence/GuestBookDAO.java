package org.snj.persistence;

import java.util.*;

import org.snj.domain.SearchCriteria;
import org.snj.domain.UserVO;
import org.snj.domain.GuestBookVO;

public interface GuestBookDAO {
	void createGuest(GuestBookVO vo) throws Exception; //방명록 등록(회원)
	void createMember(GuestBookVO vo) throws Exception; //방명록 등록(비회원)
	boolean delete(Integer gbno) throws Exception; // 방명록 삭제
	boolean passCheck(Map map) throws Exception; // 방명록 글 비빌번호 확인
	List<GuestBookVO> listCriteria(SearchCriteria cri) throws Exception; //방명록 목록
	int totalCount(SearchCriteria cri) throws Exception; // 등록된 방명록 총갯수
	void upAnsnum(Integer grpno) throws Exception; //답글인 경우 +1
	void commentMember(GuestBookVO vo) throws Exception; //답글 등록(회원)
	void commentGuest(GuestBookVO vo) throws Exception; //답글 등록(비회원)
	int getGrpno(Integer gbno) throws Exception; //답글 등록시 부모번호 가져오기
	void upCommentCount(Integer grpno) throws Exception; //답글 갯수
	GuestBookVO commentRead(int gbno) throws Exception; //답글 읽어오기
	void updateComment(Map paramMap) throws Exception; //답글 수정
	void zeroIndex() throws Exception; //등록번호 초기화
	void setIndex() throws Exception; //등록번호 정렬
}
