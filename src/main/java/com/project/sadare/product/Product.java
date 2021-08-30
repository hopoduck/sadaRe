package com.project.sadare.product;

import java.util.ArrayList;
import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import com.project.sadare.category.Category;
import com.project.sadare.member.Member;
import com.project.sadare.reply.Reply;

public class Product {

	private int product_num;
	private String product_name;
	private int product_price;
	private String product_info;
	private int category1_num, category2_num, category3_num;
	private String user_id;
	private Date product_add_date;
	private String stringDate;
	private int product_hit, product_result;
	private MultipartFile file1, file2, file3;
	private String path1, path2, path3;
	private Member member;
	private ArrayList<Reply> replys;
	private Category c1, c2, c3;

	public Product() {
	}

	public Product(int product_num, String product_name, int product_price, String product_info, int category1_num,
			int category2_num, int category3_num, String user_id, Date product_add_date, String stringDate,
			int product_hit, int product_result, MultipartFile file1, MultipartFile file2, MultipartFile file3,
			String path1, String path2, String path3, Member member, ArrayList<Reply> replys, Category c1, Category c2,
			Category c3) {
		super();
		this.product_num = product_num;
		this.product_name = product_name;
		this.product_price = product_price;
		this.product_info = product_info;
		this.category1_num = category1_num;
		this.category2_num = category2_num;
		this.category3_num = category3_num;
		this.user_id = user_id;
		this.product_add_date = product_add_date;
		this.stringDate = stringDate;
		this.product_hit = product_hit;
		this.product_result = product_result;
		this.file1 = file1;
		this.file2 = file2;
		this.file3 = file3;
		this.path1 = path1;
		this.path2 = path2;
		this.path3 = path3;
		this.member = member;
		this.replys = replys;
		this.c1 = c1;
		this.c2 = c2;
		this.c3 = c3;
	}

	public int getProduct_num() {
		return product_num;
	}

	public void setProduct_num(int product_num) {
		this.product_num = product_num;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public int getProduct_price() {
		return product_price;
	}

	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}

	public String getProduct_info() {
		return product_info;
	}

	public void setProduct_info(String product_info) {
		this.product_info = product_info;
	}

	public int getCategory1_num() {
		return category1_num;
	}

	public void setCategory1_num(int category1_num) {
		this.category1_num = category1_num;
	}

	public int getCategory2_num() {
		return category2_num;
	}

	public void setCategory2_num(int category2_num) {
		this.category2_num = category2_num;
	}

	public int getCategory3_num() {
		return category3_num;
	}

	public void setCategory3_num(int category3_num) {
		this.category3_num = category3_num;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public Date getProduct_add_date() {
		return product_add_date;
	}

	public void setProduct_add_date(Date product_add_date) {
		this.product_add_date = product_add_date;
	}

	public String getStringDate() {
		return stringDate;
	}

	public void setStringDate(String stringDate) {
		this.stringDate = stringDate;
	}

	public int getProduct_hit() {
		return product_hit;
	}

	public void setProduct_hit(int product_hit) {
		this.product_hit = product_hit;
	}

	public int getProduct_result() {
		return product_result;
	}

	public void setProduct_result(int product_result) {
		this.product_result = product_result;
	}

	public MultipartFile getFile1() {
		return file1;
	}

	public void setFile1(MultipartFile file1) {
		this.file1 = file1;
	}

	public MultipartFile getFile2() {
		return file2;
	}

	public void setFile2(MultipartFile file2) {
		this.file2 = file2;
	}

	public MultipartFile getFile3() {
		return file3;
	}

	public void setFile3(MultipartFile file3) {
		this.file3 = file3;
	}

	public String getPath1() {
		return path1;
	}

	public void setPath1(String path1) {
		this.path1 = path1;
	}

	public String getPath2() {
		return path2;
	}

	public void setPath2(String path2) {
		this.path2 = path2;
	}

	public String getPath3() {
		return path3;
	}

	public void setPath3(String path3) {
		this.path3 = path3;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public ArrayList<Reply> getReplys() {
		return replys;
	}

	public void setReplys(ArrayList<Reply> replys) {
		this.replys = replys;
	}

	public Category getC1() {
		return c1;
	}

	public void setC1(Category c1) {
		this.c1 = c1;
	}

	public Category getC2() {
		return c2;
	}

	public void setC2(Category c2) {
		this.c2 = c2;
	}

	public Category getC3() {
		return c3;
	}

	public void setC3(Category c3) {
		this.c3 = c3;
	}

	@Override
	public String toString() {
		return "Product [product_num=" + product_num + ", product_name=" + product_name + ", product_price="
				+ product_price + ", product_info=" + product_info + ", category1_num=" + category1_num
				+ ", category2_num=" + category2_num + ", category3_num=" + category3_num + ", user_id=" + user_id
				+ ", product_add_date=" + product_add_date + ", stringDate=" + stringDate + ", product_hit="
				+ product_hit + ", product_result=" + product_result + ", file1=" + file1 + ", file2=" + file2
				+ ", file3=" + file3 + ", path1=" + path1 + ", path2=" + path2 + ", path3=" + path3 + ", member="
				+ member + ", replys=" + replys + ", c1=" + c1 + ", c2=" + c2 + ", c3=" + c3 + "]";
	}

}
