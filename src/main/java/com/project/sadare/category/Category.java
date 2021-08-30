package com.project.sadare.category;

public class Category {

	private int category_num;
	private String category_name;
	private int parent_category_num;

	public Category() {
		super();
	}

	public Category(int category_num, String category_name) {
		super();
		this.category_num = category_num;
		this.category_name = category_name;
	}

	public Category(int category_num, String category_name, int parent_category_num) {
		super();
		this.category_num = category_num;
		this.category_name = category_name;
		this.parent_category_num = parent_category_num;
	}

	public int getCategory_num() {
		return category_num;
	}

	public void setCategory_num(int category_num) {
		this.category_num = category_num;
	}

	public String getCategory_name() {
		return category_name;
	}

	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}

	public int getParent_category_num() {
		return parent_category_num;
	}

	public void setParent_category_num(int parent_category_num) {
		this.parent_category_num = parent_category_num;
	}

	@Override
	public String toString() {
		return "Category [category_num=" + category_num + ", category_name=" + category_name + ", parent_category_num="
				+ parent_category_num + "]";
	}

}
