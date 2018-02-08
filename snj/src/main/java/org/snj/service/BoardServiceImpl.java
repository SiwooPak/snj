package org.snj.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.snj.domain.BoardVO;
import org.snj.domain.Criteria;
import org.snj.domain.SearchCriteria;
import org.snj.persistence.BoardDAO;
import org.snj.persistence.PointDAO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardDAO dao;
	
	@Autowired
	private PointDAO pdao;
	
	@Transactional
	@Override
	//게시글 등록
	public void regist(Map map) throws Exception {
		BoardVO vo = (BoardVO) map.get("board");
		dao.create(vo);
		
		int bno = dao.listTop(vo.getTitle());//게시글번호 가져오기, 업로드 파일 있을시 필요
		//System.out.println("============================");
		//System.out.println(bno);
		//System.out.println("============================");
		
		//작성자 포인트
		String u_id = (String) map.get("u_id");
		//System.out.println(u_id);
		pdao.updatePoint(u_id, 10);
		//업로드 파일명 저장 
		String[] files = vo.getFiles();
		if(files == null) return;
		
		Map paramMap = new HashMap();
		paramMap.put("bno", bno);
		for(String fileName : files) {
			paramMap.put("fileName", fileName);
			dao.addAttach(paramMap);
		}
	}

	@Transactional(isolation=Isolation.READ_COMMITTED)
	@Override
	public BoardVO read(int bno) throws Exception {
		//게시글 조회수 업
		dao.updateViewCnt(bno);
		//게시글 상세 읽기
		return dao.read(bno);
	}
	
	@Transactional
	@Override
	public void modify(BoardVO vo) throws Exception {
		//게시글 수정
		if(vo.getCategorycd().equals("M")) {
			String content = vo.getContent();
			//System.out.println("content: "+content);
			int startSrc = (content.indexOf("/embed/"))+7;
			content = content.substring(startSrc, startSrc+11);
			//System.out.println("content: "+content);
			vo.setThumb(content);
		}
		dao.update(vo);
		
		int bno = vo.getBno();
		//전 업로드 파일명 삭제
		dao.deleteAttach(bno);
		//신규 파일명으로 대체
		String[] files = vo.getFiles();
		
		if(files == null) return;
		for(String fileName : files) {
			dao.replaceAttach(fileName, bno);
		}
	}

	@Transactional
	@Override
	public void remove(Map map) throws Exception {
		int bno = (int) map.get("bno");
		//업로드파일명 삭제
		dao.deleteAttach(bno);
		//게시글 삭제
		dao.delete(bno);
		//포인트 감소
		String u_id = (String) map.get("writer");
		//System.out.println(u_id);
		pdao.updatePoint(u_id, -10);
	}

	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		//게시판의 글의 총 개수
		return dao.listSearchCount(cri);
	}

	@Override
	public List<String> getAttach(int bno) throws Exception {
		//게시글의 업로도 파일 가져오기.
		return dao.getAttach(bno);
	}

	@Override
	public List<BoardVO> list(SearchCriteria cri) throws Exception{
		//게시판의 글 목록
		return dao.list(cri);
	}

	@Override
	public List<Map<String, String>> categoryList() throws Exception {
		//게시판의 카테고리 목록
		return dao.categoryList();
	}

	@Override
	public List<Map<String, String>> liveList(SearchCriteria cri) throws Exception {
		return dao.liveList(cri);
	}
	
}
