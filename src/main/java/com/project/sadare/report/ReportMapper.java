package com.project.sadare.report;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ReportMapper {
	
	void insertReport(Report r);
	
	List selectAll();
	
//	void update(Report r);
	
	Report select(int report_num);

	void delete(int report_num);
}
