package com.project.sadare.notice;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

//import org.apache.ibatis.annotations.Mapper;
@Mapper
public interface NoticeMapper {


	void insertNotice(Notice n);	//
	
	List selectAllNotice();		//
	
	Notice selectNotice(int notice_num);	//
	
	void updateNotice(Notice n);
	
	void noticeHits(int notice_num);
	
	void deleteNotice(int notice_num);
	
	
	
	
}
