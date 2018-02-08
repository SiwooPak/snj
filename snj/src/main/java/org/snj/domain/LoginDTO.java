package org.snj.domain;
//로그인
public class LoginDTO {

	private String u_id; //아이디
	private String upw; //비밀번호
	private String uname; //유저명
	private boolean useCookie; //자동로그인

	public String getU_id() {
		return u_id;
	}

	public void setU_id(String u_id) {
		this.u_id = u_id;
	}

	public String getUpw() {
		return upw;
	}

	public void setUpw(String upw) {
		this.upw = upw;
	}

	public String getUname() {
		return uname;
	}

	public void setUname(String uname) {
		this.uname = uname;
	}

	public boolean isUseCookie() {
		return useCookie;
	}

	public void setUseCookie(boolean useCookie) {
		this.useCookie = useCookie;
	}

	@Override
	public String toString() {
		return "LoginDTO [u_id=" + u_id + ", upw=" + upw + ", uname=" + uname + ", useCookie=" + useCookie + "]";
	}

}
