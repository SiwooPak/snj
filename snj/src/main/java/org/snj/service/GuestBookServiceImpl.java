package org.snj.service;

import java.util.List;
import java.util.Map;

import org.snj.domain.GuestBookVO;
import org.snj.domain.SearchCriteria;
import org.snj.persistence.GuestBookDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class GuestBookServiceImpl implements GuestBookService {
	@Autowired
	private GuestBookDAO dao;

	@Override
	public List<GuestBookVO> listSearchCriteria(SearchCriteria cri) throws Exception {
		return dao.listCriteria(cri);
	}

	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		return dao.totalCount(cri);
	}

	@Transactional
	@Override
	public void registerMember(GuestBookVO vo) throws Exception {
		dao.createMember(vo);
		dao.zeroIndex();
		dao.setIndex();
	}

	@Transactional
	@Override
	public void registerGuest(GuestBookVO vo) throws Exception {
		dao.createGuest(vo);
		dao.zeroIndex();
		dao.setIndex();
	}

	@Transactional
	@Override
	public void commentMember(Map map) throws Exception {
		int gbno = (Integer) map.get("gbno");
		GuestBookVO vo = (GuestBookVO) map.get("vo");
		int grpno = dao.getGrpno(gbno);
		dao.upAnsnum(grpno);
		vo.setGrpno(grpno);
		dao.commentGuest(vo);
		dao.upCommentCount(grpno);
		dao.zeroIndex();
		dao.setIndex();
	}

	@Transactional
	@Override
	public void commentGuest(Map map) throws Exception {
		int gbno = (Integer) map.get("gbno");
		GuestBookVO vo = (GuestBookVO) map.get("vo");
		int grpno = dao.getGrpno(gbno);
		dao.upAnsnum(grpno);
		vo.setGrpno(grpno);
		dao.commentGuest(vo);
		dao.upCommentCount(grpno);
		dao.zeroIndex();
		dao.setIndex();
	}

	@Override
	public boolean deleteGB(Integer gbno) throws Exception {
		boolean flag = false;
		if (dao.delete(gbno)) {
			dao.zeroIndex();
			dao.setIndex();
			flag = true;
		}

		return flag;
	}

	@Override
	public boolean deleteGB(Map paramMap) throws Exception {
		boolean flag = false;
		if (dao.passCheck(paramMap)) {
			int gbno = (int) paramMap.get("gbno");
			if (dao.delete(gbno)) {
				dao.zeroIndex();
				dao.setIndex();
				flag = true;
				return flag;
			}
		} else {
			return flag;
		}
		return flag;
	}

	@Override
	public void updateCommentMember(Map paramMap) throws Exception {
		dao.updateComment(paramMap);
	}
	
	@Override
	public void updateCommentGuest(Map paramMap) throws Exception {
			dao.updateComment(paramMap);
	}

	@Override
	public GuestBookVO commentRead(int gbno) throws Exception {
		return dao.commentRead(gbno);
	}

	@Override
	public boolean passCheck(Map paramMap) throws Exception {
		return dao.passCheck(paramMap);
	}
	
}
