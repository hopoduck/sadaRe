package com.project.sadare.reply;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.sadare.alram.AlramService;
import com.project.sadare.member.MemberService;

@Service
public class ReplyService {

	@Autowired
	private ReplyMapper mapper;
	@Autowired
	private MemberService mService;
	@Autowired
	private AlramService aService;

//	댓글 추가
	public void addReply(Reply r) {
		mapper.insert(r);
		r.setReply_num(mapper.selectSeqCurrval());
		aService.addAlramByReply(r);
	}

//	댓글 내용 가져오기
	public Reply getReply(int reply_num) {
//		한개의 댓글 내용
		Reply r = mapper.select(reply_num);
//		댓글의 자식 댓글목록
		ArrayList<Reply> rList = getListByParent_reply_num(reply_num);
		for (int i = 0; i < rList.size(); i++) {
			Reply cReply = rList.get(i);
			cReply.setMember(mService.getMember(cReply.getUser_id()));
			rList.set(i, cReply);
		}
		r.setChild_reply(rList);
		r.setMember(mService.getMember(r.getUser_id()));
		return r;
	}

//	제품번호의 댓글 가져오기
	public ArrayList<Reply> getReplyListByProduct_num(int product_num) {
		ArrayList<Reply> list = mapper.selectListByProduct_num(product_num);
		for (int i = 0; i < list.size(); i++) {
			list.set(i, getReply(list.get(i).getReply_num()));
//			부모가 없는 댓글만 리스트에 넣는다.
			if (list.get(i).getParent_reply_num() != -1) {
				list.remove(i);
				i--;
			}
		}
		return list;
	}

//	작성자의 댓글 목록
	public ArrayList<Reply> getReplyListByWriter_id(String user_id) {
		return mapper.selectListByUser_id(user_id);
	}

//	댓글의 하위 댓글만 가져오기
	private ArrayList<Reply> getListByParent_reply_num(int parent_reply_num) {
		return mapper.selectListByParent_reply_num(parent_reply_num);
	}

//	댓글 수정
	public void editReply(Reply r) {
		mapper.update(r);
	}

//	댓글 삭제
	public void deleteReply(int reply_num) {
		mapper.delete(reply_num);
	}

	public void deleteParentReply(int reply_num) {
		mapper.deleteParent(reply_num);
	}

//	현재 번호
	public int getSeqCurrval() {
		return mapper.selectSeqCurrval();
	}

}
