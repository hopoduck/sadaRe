package com.project.sadare.member;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberService {
	@Autowired
	private MemberMapper mapper;

	public void addMember(Member m) {
		mapper.insert(m);
	}

	public Member getMember(String id) {
		return mapper.select(id);
	}

	public void editMember(Member m) {
		mapper.update(m);
	}

	public void delMember(String id) {
		mapper.delete(id);
	}

	public void changePassword(Member m) {
		mapper.changePwd(m);
	}

	public ArrayList<Member> list() {
		return mapper.list();
	}

	public void editUserScore(String user_id, int user_score) {
		mapper.updateUserScore(user_id, user_score);
	}

}
