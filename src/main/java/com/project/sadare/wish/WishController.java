package com.project.sadare.wish;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.project.sadare.product.Product;
import com.project.sadare.product.ProductService;

@Controller
public class WishController {

	@Autowired
	private WishService wService;

	@Autowired
	private ProductService pService;

	@Autowired
	private HttpSession session;

	// 찜 목록 페이지 보여주기
	@SuppressWarnings("unchecked")
	@RequestMapping("/wish/wishList")
	public String wishList(Model model) {
		String user_id = (String) session.getAttribute("user_id");
		if (user_id != null) {
			ArrayList<Wish> list = (ArrayList<Wish>) wService.selectByUserId(user_id);
			ArrayList<Product> plist = new ArrayList<Product>();
			for (int i = 0; i < list.size(); i++) {
				Wish w = list.get(i);
				Product p = pService.getProduct(w.getProduct_num());
				w.setP(p);
				plist.add(p);
			}
			model.addAttribute("list", list);
			model.addAttribute("plist", plist);
		}
		return "wish/wish";
	}

	// 있는지 확인 가능기능
	@RequestMapping("/wish/check")
	@ResponseBody
	public boolean check(@RequestParam int product_num) {
		String user_id = (String) session.getAttribute("user_id");
		Wish w = wService.selectByUserIdProductNum(product_num, user_id);
		if (w == null) {
			return false;
		} else {
			return true;
		}
	}

	// 찜 추가
	@RequestMapping("/wish/add")
	public ModelAndView addWish(@RequestParam int product_num) {
		ModelAndView mav = new ModelAndView("/wish/wishJSON");
		String user_id = (String) session.getAttribute("user_id");
		System.out.println("addWish : " + user_id + " " + product_num);

		Wish w = new Wish();

		w.setWish_num(wService.getNum());
		w.setUser_id(user_id);
		w.setProduct_num(product_num);

		System.out.println("addWish w : " + w);
		wService.insertWish(w);

		return mav;
	}

	// 찜 삭제
	@RequestMapping("/wish/delete")
	public ModelAndView delWish(@RequestParam(required = false, defaultValue = "-1") int wish_num,
			@RequestParam(required = false, defaultValue = "-1") int product_num) {
		ModelAndView mav = new ModelAndView("wish/wishJSON");
		String user_id = (String) session.getAttribute("user_id");
		if (wish_num != -1) {
			wService.deleteWish(wish_num);
		} else if (product_num != -1) {
			wService.deleteWishByProductNum(product_num, user_id);
		}
		return mav;
	}

	// 찜 리스트 전체 삭제
	@RequestMapping("/wish/wishDelAll")
	public String delAll() {
		String user_id = (String) session.getAttribute("user_id");
		wService.deleteAllWish(user_id);
		return "redirect:/wish/wishList";
	}

	@RequestMapping("/wish/count")
	@ResponseBody
	public int wishListCount() {
		String user_id = (String) session.getAttribute("user_id");
		if (user_id != null) {
			int count = wService.selectByUserId(user_id).size();
			return count;
		} else {
			return 0;
		}
	}

	@RequestMapping("/wish/countProduct")
	@ResponseBody
	public String wishProductCount(@RequestParam int product_num) {
		return Integer.toString(wService.selectByProductNum(product_num).size());
	}

}
