package org.snj.domain;

import java.util.Date;

//게시글의 댓글
public class ReplyVO {

	private Integer rno; //댓글번호
	private Integer bno; //게시글번호
	private String rcontent; //댓글 내용
	private String rwriter; //댓글 작성자
	private Date regdate; //댓글 등록일
	private Date updatedate; //댓글 수정일

	public Integer getRno() {
		return rno;
	}

	public void setRno(Integer rno) {
		this.rno = rno;
	}

	public Integer getBno() {
		return bno;
	}

	public void setBno(Integer bno) {
		this.bno = bno;
	}

	public String getRcontent() {
		return rcontent;
	}

	public void setRcontent(String rcontent) {
		this.rcontent = rcontent;
	}

	public String getRwriter() {
		return rwriter;
	}

	public void setRwriter(String rwriter) {
		this.rwriter = rwriter;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public Date getUpdatedate() {
		return updatedate;
	}

	public void setUpdatedate(Date updatedate) {
		this.updatedate = updatedate;
	}

	@Override
	public String toString() {
		return "ReplyVO [rno=" + rno + ", bno=" + bno + ", rcontent=" + rcontent + ", rwriter=" + rwriter + ", regdate="
				+ regdate + ", updatedate=" + updatedate + "]";
	}

}
