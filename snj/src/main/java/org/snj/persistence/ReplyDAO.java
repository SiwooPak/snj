package org.snj.persistence;
import java.util.List;

import org.snj.domain.Criteria;
import org.snj.domain.ReplyVO;

public interface ReplyDAO {

  List<ReplyVO> list(Integer bno) throws Exception;
  void create(ReplyVO vo) throws Exception;
  void update(ReplyVO vo) throws Exception;
  void delete(Integer rno) throws Exception;
  List<ReplyVO> listPage(Integer bno, Criteria cri) throws Exception;
  int count(Integer bno) throws Exception;
  int getBno(Integer rno) throws Exception;
  String getRwriter(Integer rno) throws Exception;
}