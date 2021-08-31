package com.project.sadare.product;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.project.sadare.util.Page;

@Controller
public class ProductController {

	private String projectPath = new File("").getAbsolutePath().toString() + "\\src\\main\\webapp";
	private String webPath = "\\static\\product\\";

	@Autowired
	private ProductService pService;

	@Autowired
	private HttpServletRequest request;
	@Autowired
	private HttpSession session;

	@RequestMapping("/")
	public String index(Model model) {
		List<Product> list = pService.getProductListByLimits(0, 8);
		model.addAttribute("list", list);
		return "index";
	}

	@GetMapping("/product/add")
	public void addForm() {
	}

	@PostMapping("/product/add")
	public String addProduct(Product p) {
		pService.addProduct(p);
		int product_num = pService.getProductSeqCurrval();
		uploadFile(p.getFile1(), product_num, 1);
		uploadFile(p.getFile2(), product_num, 2);
		uploadFile(p.getFile3(), product_num, 3);
		return "redirect:/product/view?product_num=" + product_num;
	}

//	개별파일을 프로덕트 번호의 폴더에 업로드해줌
//	컨트롤러가 아니고 메서드임!
	private void uploadFile(MultipartFile file, int product_num, int img_num) {
		File dir = new File(projectPath + webPath + product_num);
		if (!dir.exists()) {
			dir.mkdir();
		}
		if (!file.isEmpty()) {
			String uploadPath = webPath + product_num + "\\" + img_num + "_" + file.getOriginalFilename();
			File f = new File(projectPath + uploadPath);
			try {
				file.transferTo(f);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	@RequestMapping("/product/list")
	public String list(Model model, @RequestParam(defaultValue = "1", required = false) int p) {
		Page page = new Page(p, pService.getProductListSize());
		page.pageInfo();
		if (p > page.getMaxPage() && page.getMaxPage() != 0) {
			return "redirect:/product/list?p=" + page.getMaxPage();
		} else {
			List<Product> list = pService.getProductListByLimits(page.getStartList(),
					page.getStartList() + page.getListSize());
			model.addAttribute("plist", list);
			model.addAttribute("page", page);
			return request.getContextPath() + request.getRequestURI();
		}
	}

	@GetMapping("/product/search")
	public String search(@RequestParam(required = false) String q, @RequestParam(required = false) String value,
			Model model) {
		if (q != null && value != null) {
			request.setAttribute("q", q);
			request.setAttribute("value", value);
			ArrayList<Product> list = null;
			if (q.equals("product_name")) {
				list = pService.getProductListByProduct_name(value);
			} else if (q.equals("c1")) {
				int c1 = Integer.parseInt(value);
				list = pService.getProductListByCategory1_num(c1);
			} else if (q.equals("c2")) {
				int c2 = Integer.parseInt(value);
				list = pService.getProductListByCategory2_num(c2);
			} else if (q.equals("c3")) {
				int c3 = Integer.parseInt(value);
				list = pService.getProductListByCategory2_num(c3);
			} else if (q.equals("user_id")) {
				list = pService.getProductListByUser_id(value);
			}
			model.addAttribute("plist", list);
			return "/product/list";
		} else {
			return "redirect:/product/list";
		}
	}

	@RequestMapping("/product/mylist")
	public String myProductList(Model model) {
		String user_id = (String) session.getAttribute("user_id");
		ArrayList<Product> list = pService.getProductListByUser_id(user_id);
		if (user_id != null) {
			model.addAttribute("plist", list);
			return "/product/mylist";
		} else {
			return "redirect:/member/loginForm?refer=" + request.getRequestURL();
		}
	}

	@RequestMapping("/product/view")
	public void viewProduct(@RequestParam int product_num, Model model) {
		pService.editProductHit(product_num);
		Product p = pService.getProduct(product_num);
		model.addAttribute("p", p);
	}

	@RequestMapping("/product/delete")
	private String deleteProduct(@RequestParam int product_num) {
		String user_id = (String) session.getAttribute("user_id");
		int user_type = (int) session.getAttribute("user_type");
		Product p = pService.getProduct(product_num);
		if (user_id.equals(p.getUser_id()) || user_type == 2) {
			pService.deleteProduct(product_num);
			return "redirect:/product/list";
		} else {
			return "redirect:/member/login";
		}
	}

//	주문 취소
	@RequestMapping("/product/ordercancel")
	public String orderCancelProduct(int product_num) {
		Product p = pService.getProduct(product_num);
		String user_id = (String) session.getAttribute("user_id");
		if (user_id.equals(p.getUser_id())) {
//			대기중일때 0
			pService.editProductResult(product_num, 0, null);
		}
		return "redirect:/product/view?product_num=" + product_num;
	}

//	거래 예약
	@RequestMapping("/product/order")
	public String orderProduct(int product_num) {
		Product p = pService.getProduct(product_num);
		String user_id = (String) session.getAttribute("user_id");
		if (user_id.equals(p.getUser_id())) {
//			예약중일때 1
			pService.editProductResult(product_num, 1, null);
		}
		return "redirect:/product/view?product_num=" + product_num;
	}

//	거래 완료
	@RequestMapping("/product/soldout")
	public String soldOutProduct(int product_num, @RequestParam(required = false, value = "user_id") String buyer_id) {
		Product p = pService.getProduct(product_num);
		String user_id = (String) session.getAttribute("user_id");
		if (user_id.equals(p.getUser_id())) {
//			거래 완료시 2
			pService.editProductResult(product_num, 2, buyer_id);
		}
		return "redirect:/product/view?product_num=" + product_num;
	}

	public ArrayList<Product> subList(Page page, ArrayList<Product> list) {
		if (page.getCurrentPage() == page.getMaxPage()) {
			return new ArrayList<Product>(list.subList(page.getStartList(), page.getListCnt()));
		} else {
			return new ArrayList<Product>(list.subList(page.getStartList(), page.getStartList() + page.getListSize()));
		}
	}
}
