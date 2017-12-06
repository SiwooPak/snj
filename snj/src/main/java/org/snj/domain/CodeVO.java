package org.snj.domain;

public class CodeVO {
	private String commCode;
	private String commCd;
	private String commCdNm;
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
