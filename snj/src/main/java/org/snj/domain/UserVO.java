package org.snj.domain;

import java.util.Date;

public class UserVO {

	private String u_id; //아이디
	private String upw; //패스워드
	private String uname; //이름
	private int upoint; //포인트
	private String email; // 이메일
	private String userImage; // 유저이미지
	private String birth; // 생년월일
	private String postNum; // 우편번호
	private String phoneCd; // 전화번호앞자리코드
	private String phoneNum; // 전화번호뒷자리
	private String address1; // 주소
	private String address2; // 주소
	private Date regdate; // 회원가입일
	private String grade; // 회원등급
	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getUserImage() {
		return userImage;
	}

	public void setUserImage(String userImage) {
		this.userImage = userImage;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getPostNum() {
		return postNum;
	}

	public void setPostNum(String postNum) {
		this.postNum = postNum;
	}

	public String getPhoneCd() {
		return phoneCd;
	}

	public void setPhoneCd(String phoneCd) {
		this.phoneCd = phoneCd;
	}

	public String getPhoneNum() {
		return phoneNum;
	}

	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}

	public String getAddress1() {
		return address1;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

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

	public int getUpoint() {
		return upoint;
	}

	public void setUpoint(int upoint) {
		this.upoint = upoint;
	}

	@Override
	public String toString() {
		return "UserVO [u_id=" + u_id + ", upw=" + upw + ", uname=" + uname + ", upoint=" + upoint + ", email=" + email
				+ ", userImage=" + userImage + ", birth=" + birth + ", postNum=" + postNum + ", phoneCd=" + phoneCd
				+ ", phoneNum=" + phoneNum + ", address1=" + address1 + ", address2=" + address2 + ", regdate="
				+ regdate + ", grade=" + grade + "]";
	}

}