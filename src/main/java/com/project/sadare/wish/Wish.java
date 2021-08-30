package com.project.sadare.wish;

import com.project.sadare.product.Product;

public class Wish {

	private int wish_num;
	private String user_id;
	private int product_num;
	private Product p;

	public Wish() {
		super();
	}

	public Wish(int wish_num, String user_id, int product_num, Product p) {
		super();
		this.wish_num = wish_num;
		this.user_id = user_id;
		this.product_num = product_num;
		this.p = p;
	}

	public int getWish_num() {
		return wish_num;
	}

	public void setWish_num(int wish_num) {
		this.wish_num = wish_num;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public int getProduct_num() {
		return product_num;
	}

	public void setProduct_num(int product_num) {
		this.product_num = product_num;
	}

	public Product getP() {
		return p;
	}

	public void setP(Product p) {
		this.p = p;
	}

	@Override
	public String toString() {
		return "Wish [wish_num=" + wish_num + ", user_id=" + user_id + ", product_num=" + product_num + ", p=" + p
				+ "]";
	}

}
