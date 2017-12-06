package org.snj.persistence;

import java.util.*;

import org.snj.domain.SearchCriteria;
import org.snj.domain.UserVO;
import org.snj.domain.GuestBookVO;

public interface GuestBookDAO {
	void createGuest(GuestBookVO vo) throws Exception;
	void createMember(GuestBookVO vo) throws Exception;
	boolean delete(Integer gbno) throws Exception;
	boolean passCheck(Map map) throws Exception;
	List<GuestBookVO> listCriteria(SearchCriteria cri) throws Exception;
	int totalCount(SearchCriteria cri) throws Exception;
	void upAnsnum(Integer grpno) throws Exception;
	void commentMember(GuestBookVO vo) throws Exception;
	void commentGuest(GuestBookVO vo) throws Exception;
	int getGrpno(Integer gbno) throws Exception;
	void upCommentCount(Integer grpno) throws Exception;
	GuestBookVO commentRead(int gbno) throws Exception;
	void updateComment(Map paramMap) throws Exception;
	void zeroIndex() throws Exception;
	void setIndex() throws Exception;
}
