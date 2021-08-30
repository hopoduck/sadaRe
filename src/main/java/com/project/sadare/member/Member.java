package com.project.sadare.member;

import java.sql.Date;

public class Member {

	private String user_id, user_pwd, user_name, user_nickname, user_email, user_tel, user_postcode, user_addr1, user_addr2;
	private Date user_birth, user_regdate;
	private int user_score, user_scorecount, user_type;
	
	public Member() {
		super();
	}
	

	public Member(String user_id, String user_pwd, String user_name, String user_nickname, String user_email,
			String user_tel, String user_postcode, String user_addr1, String user_addr2, Date user_birth,
			Date user_regdate, int user_score, int user_scorecount, int user_type) {
		super();
		this.user_id = user_id;
		this.user_pwd = user_pwd;
		this.user_name = user_name;
		this.user_nickname = user_nickname;
		this.user_email = user_email;
		this.user_tel = user_tel;
		this.user_postcode = user_postcode;
		this.user_addr1 = user_addr1;
		this.user_addr2 = user_addr2;
		this.user_birth = user_birth;
		this.user_regdate = user_regdate;
		this.user_score = user_score;
		this.user_scorecount = user_scorecount;
		this.user_type = user_type;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUser_pwd() {
		return user_pwd;
	}

	public void setUser_pwd(String user_pwd) {
		this.user_pwd = user_pwd;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_nickname() {
		return user_nickname;
	}

	public void setUser_nickname(String user_nickname) {
		this.user_nickname = user_nickname;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public String getUser_tel() {
		return user_tel;
	}

	public void setUser_tel(String user_tel) {
		this.user_tel = user_tel;
	}

	public String getUser_postcode() {
		return user_postcode;
	}

	public void setUser_postcode(String user_postcode) {
		this.user_postcode = user_postcode;
	}

	public String getUser_addr1() {
		return user_addr1;
	}

	public void setUser_addr1(String user_addr1) {
		this.user_addr1 = user_addr1;
	}

	public String getUser_addr2() {
		return user_addr2;
	}

	public void setUser_addr2(String user_addr2) {
		this.user_addr2 = user_addr2;
	}

	public Date getUser_birth() {
		return user_birth;
	}

	public void setUser_birth(Date user_birth) {
		this.user_birth = user_birth;
	}

	public Date getUser_regdate() {
		return user_regdate;
	}

	public void setUser_regdate(Date user_regdate) {
		this.user_regdate = user_regdate;
	}

	public int getUser_score() {
		return user_score;
	}

	public void setUser_score(int user_score) {
		this.user_score = user_score;
	}

	public int getUser_scorecount() {
		return user_scorecount;
	}

	public void setUser_scorecount(int user_scorecount) {
		this.user_scorecount = user_scorecount;
	}

	public int getUser_type() {
		return user_type;
	}

	public void setUser_type(int user_type) {
		this.user_type = user_type;
	}

	@Override
	public String toString() {
		return "Member [user_id=" + user_id + ", user_pwd=" + user_pwd + ", user_name=" + user_name + ", user_nickname="
				+ user_nickname + ", user_email=" + user_email + ", user_tel=" + user_tel + ", user_postcode="
				+ user_postcode + ", user_addr1=" + user_addr1 + ", user_addr2=" + user_addr2 + ", user_birth="
				+ user_birth + ", user_regdate=" + user_regdate + ", user_score=" + user_score + ", user_scorecount="
				+ user_scorecount + ", user_type=" + user_type + "]";
	}

	
}