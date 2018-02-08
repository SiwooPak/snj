package org.snj.persistence;

import java.util.List;
import org.snj.domain.Criteria;
import org.snj.domain.ReplyVO;

//댓글
public interface ReplyDAO {

  List<ReplyVO> list(Integer bno) throws Exception; //댓글목록
  void create(ReplyVO vo) throws Exception; //댓글등록
  void update(ReplyVO vo) throws Exception; //댓글수정
  void delete(Integer rno) throws Exception; //댓글삭제
  List<ReplyVO> listPage(Integer bno, Criteria cri) throws Exception; //댓글목록
  int count(Integer bno) throws Exception; //댓글갯수
  int getBno(Integer rno) throws Exception; //댓글의 부모번호 가져오기
  String getRwriter(Integer rno) throws Exception; //댓글 작성자 가져오기
}
