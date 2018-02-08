package org.snj.domain;

import java.util.Date;
//업로드
public class AttachVO {
	private int bno; //업로드된 글번호
	private String fullname; //업로드 된 파일명
	private Date regdate; //업로드 날짜
	
	public AttachVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public AttachVO(int bno, String fullname, Date regdate) {
		super();
		this.bno = bno;
		this.fullname = fullname;
		this.regdate = regdate;
	}

	public int getBno() {
		return bno;
	}

	public void setBno(int bno) {
		this.bno = bno;
	}

	public String getFullname() {
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	@Override
	public String toString() {
		return "AttachVO [bno=" + bno + ", fullname=" + fullname + ", regdate=" + regdate + "]";
	}
}
