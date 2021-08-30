package com.project.sadare.report;

import java.sql.Date;

import com.project.sadare.product.Product;

public class Report {

	private int report_num, product_num;
	private String report_title;
	private String report_content;
	private Date report_date;
	private String report_writer_id;
	private String report_user_id;
	Product p;

	public Report() {

	}

	public Report(int report_num, int product_num, String report_title, String report_content, Date report_date,
			String report_writer_id, String report_user_id, Product p) {
		super();
		this.report_num = report_num;
		this.product_num = product_num;
		this.report_title = report_title;
		this.report_content = report_content;
		this.report_date = report_date;
		this.report_writer_id = report_writer_id;
		this.report_user_id = report_user_id;
		this.p = p;
	}

	public int getReport_num() {
		return report_num;
	}

	public void setReport_num(int report_num) {
		this.report_num = report_num;
	}

	public int getProduct_num() {
		return product_num;
	}

	public void setProduct_num(int product_num) {
		this.product_num = product_num;
	}

	public String getReport_title() {
		return report_title;
	}

	public void setReport_title(String report_title) {
		this.report_title = report_title;
	}

	public String getReport_content() {
		return report_content;
	}

	public void setReport_content(String report_content) {
		this.report_content = report_content;
	}

	public Date getReport_date() {
		return report_date;
	}

	public void setReport_date(Date report_date) {
		this.report_date = report_date;
	}

	public String getReport_writer_id() {
		return report_writer_id;
	}

	public void setReport_writer_id(String report_writer_id) {
		this.report_writer_id = report_writer_id;
	}

	public String getReport_user_id() {
		return report_user_id;
	}

	public void setReport_user_id(String report_user_id) {
		this.report_user_id = report_user_id;
	}

	public Product getP() {
		return p;
	}

	public void setP(Product p) {
		this.p = p;
	}

	@Override
	public String toString() {
		return "Report [report_num=" + report_num + ", product_num=" + product_num + ", report_title=" + report_title
				+ ", report_content=" + report_content + ", report_date=" + report_date + ", report_writer_id="
				+ report_writer_id + ", report_user_id=" + report_user_id + ", p=" + p + "]";
	}

}
