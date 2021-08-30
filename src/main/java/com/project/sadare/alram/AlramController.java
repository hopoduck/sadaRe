package com.project.sadare.alram;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.project.sadare.util.CalcDate;

@Controller
public class AlramController {

	@Autowired
	private AlramService aService;
	@Autowired
	private HttpSession session;

	@RequestMapping("/alram/mylist")
	public void myList(Model model) {
		String user_id = (String) session.getAttribute("user_id");
		ArrayList<Alram> aList = aService.getAlramListByUser_id(user_id);
		for (int i = 0; i < aList.size(); i++) {
			Alram a = aList.get(i);
			a.setStringDate(CalcDate.txtDate(a.getAlram_add_date()));
		}
		model.addAttribute("aList", aList);
	}

	@RequestMapping("/alram/getsize")
	@ResponseBody
	public int getAlramSize() {
		String user_id = (String) session.getAttribute("user_id");
		if (user_id != null) {
			return aService.getUnreadAlramListByUser_id(user_id).size();
		} else {
			return -1;
		}
	}

	@RequestMapping("/alram/read")
	@ResponseBody
	public String readAlram(@RequestParam int alram_num) {
		System.out.println("read");
		aService.editAlramRead(alram_num);
		Gson g = new Gson();
		return g.toJson("ok");
	}

	@RequestMapping("/alram/delete")
	@ResponseBody
	public String deleteAlram(@RequestParam int alram_num) {
		System.out.println("alram : " + alram_num);
		aService.deleteAlram(alram_num);
		return "success";
	}

	@RequestMapping("/alram/deleteall")
	@ResponseBody
	public String deleteAlram() {
		String user_id = (String) session.getAttribute("user_id");
		if (user_id != null) {
			aService.deleteAlramByUser_id(user_id);
		}
		return "success";
	}

}
