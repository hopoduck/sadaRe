package com.project.sadare.wish;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface WishMapper {

	void insertWish(Wish w);

	@SuppressWarnings("rawtypes")
	List selectWishNum(int wish_num);

	@SuppressWarnings("rawtypes")
	List selectByUserId(String user_id);

	@SuppressWarnings("rawtypes")
	List selectByProductNum(int product_num);

	Wish selectByUserIdProductNum(String user_id, int product_num);

	void deleteWish(int wish_num);

	void deleteAllWish(String user_id);

	void deleteWishByProductNum(String user_id, int product_num);

	int getNum();

}
