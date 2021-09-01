package com.project.sadare.alram;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.sadare.product.Product;
import com.project.sadare.product.ProductService;
import com.project.sadare.reply.Reply;
import com.project.sadare.reply.ReplyService;

@Service
public class AlramService {

	@Autowired
	private AlramMapper mapper;
	@Autowired
	private ReplyService rService;
	@Autowired
	private ProductService pService;
	@Autowired
	private HttpServletRequest request;

//	알람추가
	public void addAlram(Alram a) {
		mapper.insert(a);
	}

	public void addAlramByReply(Reply r) {
		Alram a = new Alram();
		Product p = pService.getProduct(r.getProduct_num());
		a.setProduct_num(p.getProduct_num());
		a.setAlram_count(1);
		a.setAlram_read(0);
		a.setUser_id(p.getUser_id());
		System.out.println(r.getParent_reply_num());
		System.out.println(r.getUser_id() + ":" + a.getUser_id());
//		제품에 달린 댓글 => 제품을 작성한 사람에게 / 댓글 작성자가 알람 대상자가 아닐 때 
		if (r.getParent_reply_num() == -1 && !r.getUser_id().equals(a.getUser_id())) {
			System.out.println("제품에 댓글");
			a.setAlram_type(1);
			a.setAlram_href(request.getContextPath() + "/product/view?product_num=" + p.getProduct_num() + "#reply-"
					+ r.getReply_num());
			checkDuplicateAlram(a);
		}
//		댓글에 달린 하위 댓글 => 상위 댓글을 작성한 사람에게
		if (r.getParent_reply_num() != -1) {
			System.out.println("댓글의 댓글");
			Reply pReply = rService.getReply(r.getParent_reply_num());
			a.setUser_id(pReply.getUser_id());
			if (r.getParent_reply_num() != -1 && !r.getUser_id().equals(a.getUser_id())) {
				a.setUser_id(pReply.getUser_id());
				a.setAlram_type(2);
				a.setAlram_href(request.getContextPath() + "/product/view?product_num=" + p.getProduct_num() + "#reply-"
						+ r.getReply_num());
				checkDuplicateAlram(a);
			}
		}
	}

	public void checkDuplicateAlram(Alram a) {
		if (getAlramByAlram(a) != null) {
			System.out.println("알람수정");
			System.out.println(a);
			editAlramCount(getAlramByAlram(a).getAlram_num());
		} else {
			System.out.println("알람추가");
			System.out.println(a);
			addAlram(a);
		}
	}

//	알람 선택
	public Alram getAlram(int alram_num) {
		return mapper.select(alram_num);
	}

//	유저의 알람 내역 가져오기
	public ArrayList<Alram> getAlramListByUser_id(String user_id) {
		return mapper.selectListByUser_id(user_id);
	}

//	유저의 읽지 않은 알람 내역 가져오기
	public ArrayList<Alram> getUnreadAlramListByUser_id(String user_id) {
		return mapper.selectUnreadListByUser_id(user_id);
	}

//	동일한 알람이 존재하는지 확인
	public Alram getAlramByAlram(Alram a) {
		return mapper.selectByAlram(a);
	}

//	알람 내용 수정(동일한 타입의 알람 발생 시 숫자 증가)
	public void editAlramCount(int alram_num) {
		mapper.updateAlramCount(alram_num);
	}

//	알람 내용 확인시 읽음 처리
	public void editAlramRead(int alram_num) {
		mapper.updateAlramRead(alram_num);
	}

//	알람 내용 수정
	public void editAlram(Alram a) {
		mapper.updateAlram(a);
	}

//	알람 삭제
	public void deleteAlram(int alram_num) {
		mapper.delete(alram_num);
	}

//	유저의 알람 전체 삭제
	public void deleteAlramByUser_id(String user_id) {
		mapper.deleteByUser_id(user_id);
	}

}
