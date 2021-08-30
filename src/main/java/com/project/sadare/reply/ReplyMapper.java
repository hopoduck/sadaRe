package com.project.sadare.reply;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ReplyMapper {

	void insert(Reply r);

	Reply select(int reply_num);

	ArrayList<Reply> selectListByProduct_num(int product_num);

	ArrayList<Reply> selectListByUser_id(String user_id);

	ArrayList<Reply> selectListByParent_reply_num(int parent_reply_num);

	void update(Reply r);

	void delete(int reply_num);

	void deleteParent(int reply_num);

	int selectSeqCurrval();

}
