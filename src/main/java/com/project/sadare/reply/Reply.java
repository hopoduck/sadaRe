package com.project.sadare.reply;

import java.sql.Date;
import java.util.ArrayList;

import com.project.sadare.member.Member;

public class Reply {

	private int reply_num;
	private String user_id, reply_content;
	private int product_num;
	private Date reply_date;
	private int parent_reply_num;
	private ArrayList<Reply> child_reply;
	private Member member;

	public Reply() {
	}

	public Reply(int reply_num, String user_id, String reply_content, int product_num, Date reply_date,
			int parent_reply_num, ArrayList<Reply> child_reply, Member member) {
		super();
		this.reply_num = reply_num;
		this.user_id = user_id;
		this.reply_content = reply_content;
		this.product_num = product_num;
		this.reply_date = reply_date;
		this.parent_reply_num = parent_reply_num;
		this.child_reply = child_reply;
		this.member = member;
	}

	public int getReply_num() {
		return reply_num;
	}

	public void setReply_num(int reply_num) {
		this.reply_num = reply_num;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getReply_content() {
		return reply_content;
	}

	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}

	public int getProduct_num() {
		return product_num;
	}

	public void setProduct_num(int product_num) {
		this.product_num = product_num;
	}

	public Date getReply_date() {
		return reply_date;
	}

	public void setReply_date(Date reply_date) {
		this.reply_date = reply_date;
	}

	public int getParent_reply_num() {
		return parent_reply_num;
	}

	public void setParent_reply_num(int parent_reply_num) {
		this.parent_reply_num = parent_reply_num;
	}

	public ArrayList<Reply> getChild_reply() {
		return child_reply;
	}

	public void setChild_reply(ArrayList<Reply> child_reply) {
		this.child_reply = child_reply;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	@Override
	public String toString() {
		return "Reply [reply_num=" + reply_num + ", user_id=" + user_id + ", reply_content=" + reply_content
				+ ", product_num=" + product_num + ", reply_date=" + reply_date + ", parent_reply_num="
				+ parent_reply_num + ", child_reply=" + child_reply + ", member=" + member + "]";
	}

}