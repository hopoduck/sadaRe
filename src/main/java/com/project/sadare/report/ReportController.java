package com.project.sadare.report;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.project.sadare.product.Product;
import com.project.sadare.product.ProductService;

@Controller
public class ReportController {

	@Autowired
	private ReportService rService;
	@Autowired
	private ProductService pService;

	@Autowired
	private HttpSession session;

	@RequestMapping(value = "/report/reportForm")
	public void reportForm(@RequestParam int product_num, Model model) {
		model.addAttribute("product_num", product_num);
	}

	@PostMapping(value = "/report/add")
	public String insertReport(Report r) {
		String writer_id = (String) session.getAttribute("user_id");
		Product p = pService.getProduct(r.getProduct_num());
		String pId = p.getUser_id();
		r.setReport_writer_id(writer_id);
		r.setReport_user_id(pId);
		rService.insertReport(r);
		return "redirect:/product/view?product_num=" + r.getProduct_num();
	}

	@RequestMapping(value = "/report/reportList")
	// admin계정에서 보이는 신고접수된list
	public String reportList(Model model) {
		String user_id = (String) session.getAttribute("user_id");
		if (user_id != null) {
			ArrayList<Report> list = (ArrayList<Report>) rService.selectAll();
			ArrayList<Product> plist = new ArrayList<Product>();
			for (int i = 0; i < list.size(); i++) {
				Report r = list.get(i);
				Product p = pService.getProduct(r.getProduct_num());
				r.setP(p);
				plist.add(p);
			}
			model.addAttribute("list", list);
		}
		return "/report/reportList";
	}

	@RequestMapping(value = "/report/reportValue")
	public ModelAndView reportValue(int report_num) {
		ModelAndView mav = new ModelAndView("report/reportValue");
		String user_id = (String) session.getAttribute("user_id");
		Report r = rService.getReport(report_num);
		mav.addObject("r", r);
		return mav;
	}

//	@RequestMapping(value = "/report/value")
//	public void value(Report r) {
//		rService.fakeEdit(r);
//	}

	@RequestMapping(value = "/report/delete")
	public void delete(int report_num) {
		rService.delReport(report_num);
	}

}
