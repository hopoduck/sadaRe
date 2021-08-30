package com.project.sadare.wish;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class WishService {

	@Autowired
	private WishMapper mapper;

	public void insertWish(Wish w) {
		mapper.insertWish(w);
	}

	public List selectByUserId(String user_id) {
		return mapper.selectByUserId(user_id);
	}

	public List selectByProductNum(int product_num) {
		return mapper.selectByProductNum(product_num);
	}

	public void deleteWish(int wish_num) {
		mapper.deleteWish(wish_num);
	}

	public void deleteAllWish(String user_id) {
		mapper.deleteAllWish(user_id);
	}

	public void deleteWishByProductNum(int product_num, String user_id) {
		mapper.deleteWishByProductNum(user_id, product_num);
	}

	public Wish selectByUserIdProductNum(int product_num, String user_id) {
		return mapper.selectByUserIdProductNum(user_id, product_num);
	}

	public int getNum() {
		return mapper.getNum();
	}
}
