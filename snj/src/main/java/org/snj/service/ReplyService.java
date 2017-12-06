package org.snj.service;

import java.util.List;

import org.snj.domain.Criteria;
import org.snj.domain.ReplyVO;

public interface ReplyService {
	List<ReplyVO> list(int bno) throws Exception;
	void addReply(ReplyVO vo) throws Exception;
	void modReply(ReplyVO vo) throws Exception;
	void delReply(int rno) throws Exception;
	List<ReplyVO> listPage(int bno, Criteria cri) throws Exception;
	int count(int bno) throws Exception;
}
