package com.project.sadare.report;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReportService{
	
	@Autowired
	private ReportMapper mapper;

	public void insertReport(Report r) {
		mapper.insertReport(r);		
	}
	
	public List selectAll() {
		return mapper.selectAll();
	}
	
//	public void fakeEdit(Report r) {
//		mapper.update(r);
//	}
	
	public Report getReport(int report_num) {
		return mapper.select(report_num);
	}
	public void delReport(int report_num) {
		mapper.delete(report_num);
	}

}
