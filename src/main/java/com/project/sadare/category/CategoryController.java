package com.project.sadare.category;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

@Controller
public class CategoryController {

	@Autowired
	private CategoryService cService;

	@RequestMapping("/admin/category")
	public void categoryView(Model model) {
		model.addAttribute("c1List", cService.getCategoryList(1, 0));
	}

//	카테고리 추가
	@RequestMapping(value = "/category/add")
	@ResponseBody
	public String addCategory(@RequestParam String category_name, @RequestParam int category_type,
			@RequestParam(required = false, defaultValue = "-1") int parent_category_num) {
		Category c = null;
		if (category_type == 1) {
			c = new Category(0, category_name);
		} else if (category_type == 2) {
			c = new Category(0, category_name, parent_category_num);
		} else if (category_type == 3) {
			c = new Category(0, category_name, parent_category_num);
		}
		cService.addCategory(category_type, c);
		return getCategory(parent_category_num, category_type);
	}

//	화면에 출력
	@RequestMapping(value = "/category/getCategory")
	@ResponseBody
	public String getCategory(@RequestParam(required = false, defaultValue = "-1") int parent_category_num,
			@RequestParam int category_type) {
		ArrayList<Category> category_list = null;
		switch (category_type) {
		case 1:
			category_list = (ArrayList<Category>) cService.getCategoryList(1, 0);
			break;
		case 2:
			category_list = (ArrayList<Category>) cService.getCategoryList(2, parent_category_num);
			break;
		case 3:
			category_list = (ArrayList<Category>) cService.getCategoryList(3, parent_category_num);
			break;
		}
		Gson g = new Gson();
		return g.toJson(category_list);
	}
//
//	// 카테고리 수정
//	@RequestMapping(value = "/category/updateCategory")
//	public ModelAndView updateCategory(@RequestParam(value = "category_type") int category_type,
//			@RequestParam(value = "category_num") int category_num,
//			@RequestParam(value = "category_name") String category_name) {
//		System.out.println("수정 category_num : " + category_num);
//		System.out.println("수정 category_type : " + category_type);
//		System.out.println("수정 category_name : " + category_name);
//
//		// 수정 전 카테고리
//		Category c1 = cService.selectCategory(category_num, category_type);
//		// 수정 후 카테고리
//		Category c2 = new Category(category_num, category_name, c1.getParent_category_num());
//		cService.updateCategory(c2, category_type);
//
//		ModelAndView mav = new ModelAndView("/admin/categoryJSON");
//		ArrayList<Category> category_list = null;
//
//		switch (category_type) {
//		case 1:
//			category_list = (ArrayList<Category>) cService.selectAllCategory(0, 1);
//			break;
//		case 2:
//			category_list = (ArrayList<Category>) cService.selectAllCategory(c2.getParent_category_num(), 2);
//			break;
//		case 3:
//			category_list = (ArrayList<Category>) cService.selectAllCategory(c2.getParent_category_num(), 3);
//			break;
//		}
//		mav.addObject("category_list", category_list);
//
//		return mav; 
//	}

//	카테고리 삭제
	@RequestMapping(value = "/category/delete")
	@ResponseBody
	public String deleteCategory(@RequestParam int category_type, @RequestParam int category_num) {
		Category c = cService.getCategory(category_type, category_num);
		cService.deleteCategory(category_type, category_num);
		return getCategory(c.getParent_category_num(), category_type);
	}

}
