package com.project.sadare.alram;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AlramMapper {

	void insert(Alram r);

	Alram select(int alram_num);

	ArrayList<Alram> selectListByUser_id(String user_id);

	ArrayList<Alram> selectUnreadListByUser_id(String user_id);

	Alram selectByAlram(Alram a);

	void updateAlramCount(int alram_num);

	void updateAlramRead(int alram_num);

	void updateAlram(Alram a);

	void delete(int alram_num);

	void deleteByUser_id(String user_id);

}
