package org.snj.domain;

import java.util.Arrays;
import java.util.Date;
//게시판
public class BoardVO {
	
	private Integer bno; //게시글 번호
	private String title; //게시글 제목
	private String content; //게시글 내용
	private String writer; //게시글 작성자
	private Date regdate; //게시글 등록 날짜
	private int viewcnt; //게시글 조회수
	private int replycnt; //게시글의 댓글수
	private String categorycd; //게시글의 카테고리
	private String thumb; // 썸네일 이미지
	private String[] files; // 업로드된 파일이름들
	
	public String[] getFiles() {
		return files;
	}
	public void setFiles(String[] files) {
		this.files = files;
	}
	public int getReplycnt() {
		return replycnt;
	}
	public void setReplycnt(int replycnt) {
		this.replycnt = replycnt;
	}
	public Integer getBno() {
		return bno;
	}
	public void setBno(Integer bno) {
		this.bno = bno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public int getViewcnt() {
		return viewcnt;
	}
	public void setViewcnt(int viewcnt) {
		this.viewcnt = viewcnt;
	}

	public String getCategorycd() {
		return categorycd;
	}
	public void setCategorycd(String categorycd) {
		this.categorycd = categorycd;
	}
	public String getThumb() {
		return thumb;
	}
	public void setThumb(String thumb) {
		this.thumb = thumb;
	}
	
	@Override
	public String toString() {
		return "BoardVO [bno=" + bno + ", title=" + title + ", content=" + content + ", writer=" + writer + ", regdate="
				+ regdate + ", viewcnt=" + viewcnt + ", replycnt=" + replycnt + ", categorycd=" + categorycd
				+ ", thumb=" + thumb + ", files=" + Arrays.toString(files) + "]";
	}

}
