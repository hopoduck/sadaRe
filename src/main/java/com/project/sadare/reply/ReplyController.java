package com.project.sadare.reply;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ReplyController {

	@Autowired
	private ReplyService rService;
	@Autowired
	private HttpServletRequest request;
	@Autowired
	private HttpSession session;

	@PostMapping("/reply/add")
	public String addReply(Reply r) {
		r.setUser_id((String) session.getAttribute("user_id"));
		rService.addReply(r);
		return "redirect:" + request.getHeader("REFERER") + "#reply-" + rService.getSeqCurrval();
	}

	@PostMapping("/reply/edit")
	public String editReply(Reply r) {
		String user_id = (String) session.getAttribute("user_id");
		if (user_id.equals(r.getUser_id())) {
			r.setUser_id(user_id);
			rService.editReply(r);
		}
		return "redirect:" + request.getHeader("REFERER") + "#reply-" + r.getReply_num();
	}

//	댓글 삭제
	@RequestMapping("/reply/delete")
	public String deleteReply(@RequestParam int reply_num) {
		String user_id = (String) session.getAttribute("user_id");
		Reply r = rService.getReply(reply_num);
		if (user_id.equals(r.getUser_id())) {
//			하위 댓글이 있을 때 내용을 null로 변경한다.
			if (r.getChild_reply().size() != 0 || r.getParent_reply_num() != -1) {
				rService.deleteParentReply(reply_num);
			} else {
//				없을때에는 그냥 삭제
				rService.deleteReply(reply_num);
			}
		}
		return "redirect:" + request.getHeader("REFERER");
	}

}
