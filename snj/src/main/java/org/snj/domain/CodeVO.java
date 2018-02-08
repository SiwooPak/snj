package org.snj.domain;
//카테고리
public class CodeVO {
	private String commCode; //코드
	private String commCd; //게시판 코드번호
	private String commCdNm; //게시판 이름
	public String getCommCode() {
		return commCode;
	}
	public void setCommCode(String commCode) {
		this.commCode = commCode;
	}
	public String getCommCd() {
		return commCd;
	}
	public void setCommCd(String commCd) {
		this.commCd = commCd;
	}
	public String getCommCdNm() {
		return commCdNm;
	}
	public void setCommCdNm(String commCdNm) {
		this.commCdNm = commCdNm;
	}
	@Override
	public String toString() {
		return "CodeVO [commCode=" + commCode + ", commCd=" + commCd + ", commCdNm=" + commCdNm + "]";
	}
	
}
