package org.snj.service;

import java.util.List;
import java.util.Map;

import org.snj.domain.SearchCriteria;
import org.snj.domain.UserVO;
import org.snj.domain.GuestBookVO;

public interface GuestBookService {
	List<GuestBookVO> listSearchCriteria(SearchCriteria cri) throws Exception;
	int listSearchCount(SearchCriteria cri) throws Exception;
	void registerMember(GuestBookVO vo) throws Exception;
	void registerGuest(GuestBookVO vo) throws Exception;
	void commentMember(Map paramMap) throws Exception;
	void commentGuest(Map paramMap) throws Exception;
	boolean deleteGB(Integer gbno) throws Exception;
	boolean deleteGB(Map paramMap) throws Exception;
	void updateCommentMember(Map paramMap) throws Exception;
	boolean passCheck(Map paramMap) throws Exception;
	void updateCommentGuest(Map paramMap) throws Exception;
	GuestBookVO commentRead(int gbno) throws Exception;
}
