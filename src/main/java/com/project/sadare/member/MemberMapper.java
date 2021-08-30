package com.project.sadare.member;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberMapper {

	void insert(Member m);

	Member select(String id);

	void update(Member m);

	void delete(String id);

	ArrayList<Member> list();

	void changePwd(Member m);

	void updateUserScore(String user_id, int user_score);
	
}
