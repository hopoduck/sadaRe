package com.project.sadare.product;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.text.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.sadare.alram.Alram;
import com.project.sadare.alram.AlramService;
import com.project.sadare.category.CategoryService;
import com.project.sadare.member.MemberService;
import com.project.sadare.reply.ReplyService;
import com.project.sadare.util.CalcDate;
import com.project.sadare.wish.Wish;
import com.project.sadare.wish.WishService;

@Service
public class ProductService {

	private String projectPath = new File("").getAbsolutePath().toString() + "\\src\\main\\webapp";
	private String webPath = "\\static\\product\\";

	@Autowired
	private ProductMapper mapper;
	@Autowired
	private MemberService mService;
	@Autowired
	private ReplyService rService;
	@Autowired
	private CategoryService cService;
	@Autowired
	private AlramService aService;
	@Autowired
	private WishService wService;
	@Autowired
	private HttpServletRequest request;

//	제품등록 => 대표이미지, 세부이미지 *2
	public void addProduct(Product p) {
		mapper.insert(p);
	}

	public int getProductListSize() {
		return mapper.selectListSize();
	}

//	제품 상세보기
	public Product getProduct(int product_num) {
		Product p = mapper.select(product_num);
		p = productSetPath(p);
		p.setProduct_info(StringEscapeUtils.escapeHtml4(p.getProduct_info()));
		p.setMember(mService.getMember(p.getUser_id()));
		p.setReplys(rService.getReplyListByProduct_num(p.getProduct_num()));
		p.setC1(cService.getCategory(1, p.getCategory1_num()));
		p.setC2(cService.getCategory(2, p.getCategory2_num()));
		p.setC3(cService.getCategory(3, p.getCategory3_num()));
		p.setStringDate(CalcDate.txtDate(p.getProduct_add_date()));
		return p;
	}

	private ArrayList<Product> setProductData(ArrayList<Product> list) {
		for (int i = 0; i < list.size(); i++) {
			Product p = list.get(i);
			p = productSetPath(p);
			p.setProduct_info(StringEscapeUtils.escapeHtml4(p.getProduct_info()));
			p.setMember(mService.getMember(p.getUser_id()));
			p.setReplys(rService.getReplyListByProduct_num(p.getProduct_num()));
			p.setC1(cService.getCategory(1, p.getCategory1_num()));
			p.setC2(cService.getCategory(2, p.getCategory2_num()));
			p.setC3(cService.getCategory(3, p.getCategory3_num()));
			p.setStringDate(CalcDate.txtDate(p.getProduct_add_date()));
			list.set(i, p);
		}
		return list;
	}

//	전체 제품 목록
	public ArrayList<Product> getProductList() {
		return setProductData(mapper.selectList());
	}

//	전체 제품 목록
	public ArrayList<Product> getProductListByLimits(int start, int last) {
		return setProductData(mapper.selectListByLimit(start, last));
	}

//	제품 검색
	public ArrayList<Product> getProductListByProduct_name(String product_name) {
		return setProductData(mapper.selectListByProduct_name(product_name));
	}

//	카테고리별 검색
	public ArrayList<Product> getProductListByCategory1_num(int category1_num) {
		return setProductData(mapper.selectListByCategory1_num(category1_num));
	}

	public ArrayList<Product> getProductListByCategory2_num(int category2_num) {
		return setProductData(mapper.selectListByCategory2_num(category2_num));
	}

	public ArrayList<Product> getProductListByCategory3_num(int category3_num) {
		return setProductData(mapper.selectListByCategory3_num(category3_num));
	}

//	회원이 등록한 제품 보기
	public ArrayList<Product> getProductListByUser_id(String user_id) {
		return setProductData(mapper.selectListByUser_id(user_id));
	}

//	제품 내용 수정
	public void editProduct(Product p) {
		mapper.update(p);
	}

//	조회수 추가
	public void editProductHit(int product_num) {
		mapper.updateHit(product_num);
	}

//	제품 거래결과 수정 (판매중/판매완료)
	public void editProductResult(int product_num, int result, String buyer_id) {
		Alram a = new Alram();
		@SuppressWarnings("unchecked")
		ArrayList<Wish> list = (ArrayList<Wish>) wService.selectByProductNum(product_num);
		for (int i = 0; i < list.size(); i++) {
			Wish w = list.get(i);
			a.setUser_id(w.getUser_id());
			a.setProduct_num(product_num);
			a.setAlram_type(result + 3);
			a.setAlram_count(1);
			a.setAlram_href(request.getContextPath() + "/product/view?product_num=" + product_num);
//			예약상태 취소 : result == 0
//			예약상태로 변경 : result == 1
			a.setAlram_read(0);
			aService.addAlram(a);
		}
		if (buyer_id != null && result == 2) {
//			거래 완료상태 : result == 2
			a.setUser_id(buyer_id);
			a.setProduct_num(product_num);
			a.setAlram_type(result + 3);
			a.setAlram_count(1);
			a.setAlram_href(request.getContextPath() + "/product/view?product_num=" + product_num);
			aService.addAlram(a);
		}
		mapper.updateResult(product_num, result);
	}

//	제품 삭제
	public void deleteProduct(int product_num) {
		mapper.delete(product_num);
	}

//	현재 시퀀스 값 가져오기
	public int getProductSeqCurrval() {
		return mapper.selectSeqCurrval();
	}

//	프로덕트 위치의 이미지 목록 불러오기
	private String[] getFileList(int product_num) {
		File dir = new File(projectPath + webPath + product_num);
		String[] files = dir.list();
		if (files != null) {
			for (int i = 0; i < files.length; i++) {
				files[i] = webPath.replace("\\", "/") + product_num + "/" + files[i];
			}
		} else {
			files = new String[1];
			files[0] = "";
		}
		return files;
	}

//	프로덕트에 파일 이미지 붙이기
	private Product productSetPath(Product p) {
		String[] files = getFileList(p.getProduct_num());
		if (files.length >= 1 && !files[0].equals("")) {
			p.setPath1(files[0]);
			if (files.length >= 2) {
				p.setPath2(files[1]);
				if (files.length >= 3) {
					p.setPath3(files[2]);
				}
			}
		} else {
			p.setPath1("https://dummyimage.com/286x150/fff/000.png&text=No+Image");
		}
		return p;
	}

}
