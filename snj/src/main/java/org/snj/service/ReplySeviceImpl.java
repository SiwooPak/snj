package org.snj.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.snj.domain.Criteria;
import org.snj.domain.ReplyVO;
import org.snj.persistence.BoardDAO;
import org.snj.persistence.PointDAO;
import org.snj.persistence.ReplyDAO;

@Service
public class ReplySeviceImpl implements ReplyService {
	@Autowired
	private ReplyDAO dao;
	
	@Autowired
	private BoardDAO bdao;
	
	@Autowired
	private PointDAO pdao;
	
	@Override
	public List<ReplyVO> list(int bno) throws Exception {
		
		return dao.list(bno);
	}
	
	@Transactional
	@Override
	public void addReply(ReplyVO vo) throws Exception {
		dao.create(vo);
		pdao.updatePoint(vo.getRwriter(), 5);
		bdao.updateReplyCnt(vo.getBno(), 1);
	}

	@Override
	public void modReply(ReplyVO vo) throws Exception {
		dao.update(vo);
	}

	@Transactional
	@Override
	public void delReply(int rno) throws Exception {
		String uid = dao.getRwriter(rno);
		int bno = dao.getBno(rno);
		dao.delete(rno);
		pdao.updatePoint(uid, -5);
		bdao.updateReplyCnt(bno, -1);
	}

	@Override
	public List<ReplyVO> listPage(int bno, Criteria cri) throws Exception {
		return dao.listPage(bno, cri);
	}

	@Override
	public int count(int bno) throws Exception {
		return dao.count(bno);
	}

}
