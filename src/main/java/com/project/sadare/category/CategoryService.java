package com.project.sadare.category;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CategoryService {

	@Autowired
	private CategoryMapper mapper;

	public void addCategory(int type, Category c) {
		switch (type) {
		case 1:
			mapper.insertCategory1(c);
			break;
		case 2:
			mapper.insertCategory2(c);
			break;
		case 3:
			mapper.insertCategory3(c);
			break;
		}
	}

	public Category getCategory(int type, int category_num) {
		Category c = null;
		switch (type) {
		case 1:
			c = mapper.selectCategory1(category_num);
			break;
		case 2:
			c = mapper.selectCategory2(category_num);
			break;
		case 3:
			c = mapper.selectCategory3(category_num);
			break;
		}
		return c;
	}

	public ArrayList<Category> getCategoryList(int type, int parent_category_num) {
		ArrayList<Category> list = null;
		switch (type) {
		case 1:
			list = mapper.selectAllCategory1();
			break;
		case 2:
			list = mapper.selectAllCategory2(parent_category_num);
			break;
		case 3:
			list = mapper.selectAllCategory3(parent_category_num);
			break;
		}
		return list;
	}

	public void editCategory(int type, Category c) {
		switch (type) {
		case 1:
			mapper.updateCategory1(c);
			break;
		case 2:
			mapper.updateCategory2(c);
			break;
		case 3:
			mapper.updateCategory3(c);
			break;
		}
	}

	public void deleteCategory(int type, int num) {
		switch (type) {
		case 1:
			mapper.deleteCategory1(num);
			break;
		case 2:
			mapper.deleteCategory2(num);
			break;
		case 3:
			mapper.deleteCategory3(num);
			break;
		}
	}

	public int getNum(int type) {
		int category_num = 0;
		switch (type) {
		case 1:
			category_num = mapper.getNum1();
			break;
		case 2:
			category_num = mapper.getNum2();
			break;
		case 3:
			category_num = mapper.getNum3();
			break;
		}
		return category_num;
	}
}
