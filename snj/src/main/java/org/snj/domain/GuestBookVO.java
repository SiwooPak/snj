package org.snj.domain;

import java.util.Date;

public class GuestBookVO {
	private int gbno;
	private String writer;
	private String content;
	private String regdate;
	private String pass;
	private int grpno;
	private int ansnum;
	private int commentCnt;
	
	public GuestBookVO() {
		super();
	}

	//회원일때
	public GuestBookVO(String writer, String content) {
		super();
		this.writer = writer;
		this.content = content;
	}
	//비회원일때
	public GuestBookVO(String writer, String content, String pass) {
		super();
		this.writer = writer;
		this.content = content;
		this.pass = pass;
	}

	public int getGbno() {
		return gbno;
	}

	public void setGbno(int gbno) {
		this.gbno = gbno;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public int getGrpno() {
		return grpno;
	}

	public void setGrpno(int grpno) {
		this.grpno = grpno;
	}

	public int getAnsnum() {
		return ansnum;
	}

	public void setAnsnum(int ansnum) {
		this.ansnum = ansnum;
	}

	public int getCommentCnt() {
		return commentCnt;
	}
	
	public void setCommentCnt(int commentCnt) {
		this.commentCnt = commentCnt;
	}
	
	@Override
	public String toString() {
		return "GuestBookVO [gbno=" + gbno + ", writer=" + writer + ", content=" + content + ", regdate=" + regdate
				+ ", pass=" + pass + ", grpno=" + grpno + ", ansnum=" + ansnum + ",commentCnt="+ commentCnt+"]";
	}


}
