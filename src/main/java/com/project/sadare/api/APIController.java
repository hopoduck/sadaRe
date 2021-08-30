package com.project.sadare.api;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.sadare.member.Member;
import com.project.sadare.member.MemberService;
import com.project.sadare.product.ProductService;

@Controller
public class APIController {

	@Autowired
	private ProductService pService;
	@Autowired
	private MemberService mService;

	@Autowired
	private HttpSession session;

	@RequestMapping("/api/product/getName")
	@ResponseBody
	public String getProductName(@RequestParam int product_num) {
		return pService.getProduct(product_num).getProduct_name();
	}

	@RequestMapping("/api/member/getScore")
	@ResponseBody
	public double getMemberScore() {
		String user_id = (String) session.getAttribute("user_id");
		Member m = mService.getMember(user_id);
		if (m.getUser_scorecount() != 0) {
			return (double) m.getUser_score() / m.getUser_scorecount();
		} else {
			return -1;
		}
	}

	@RequestMapping("/api/member/getUserIdByProductNum")
	@ResponseBody
	public String getUserIdByProductNum(@RequestParam int product_num) {
		return pService.getProduct(product_num).getUser_id();
	}

	@RequestMapping("/api/member/getUserType")
	@ResponseBody
	public int getUserType() {
		String user_id = (String) session.getAttribute("user_id");
		if (user_id != null) {
			return mService.getMember(user_id).getUser_type();
		} else {
			return -1;
		}
	}
}
