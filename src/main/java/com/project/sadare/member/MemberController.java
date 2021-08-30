package com.project.sadare.member;

import java.sql.Date;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.project.sadare.alram.Alram;
import com.project.sadare.alram.AlramService;

@Controller
public class MemberController {

	@Autowired
	private MemberService service;
	@Autowired
	private AlramService aService;

	@GetMapping(value = "/member/loginForm")
	public String loginForm(HttpServletRequest req, @RequestParam(value = "refer", required = false) String refer) {
//		model.addAttribute("r", "로그인");

//		sessionChk(req);
		HttpSession session = req.getSession(false);
		if (session != null) {
			if (session.getAttribute("user_id") != null) {
				return "redirect:/member/main";
			} else {
				System.out.println(
						"세션값 있음, 아이디값 없음" + req.getRequestURI() + "\n" + req.getRequestURI().getClass().getName());
				return req.getRequestURI();
//				return "/member/loginForm";
			}

		} else {
			System.out.println("세션값 없음" + req.getRequestURI() + "\n" + req.getRequestURI().getClass().getName());

			return req.getRequestURI();
//			return "/member/loginForm";
		}
	}

	@RequestMapping(value = "/member/joinForm")
	public String joinForm(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		String id = (String) session.getAttribute("user_id");
		if (id != null) {
			return "redirect:/member/main";
		} else {
			return req.getRequestURI();
		}
	}

	@SuppressWarnings("unchecked")
	@PostMapping(value = "/member/idCheck")
	@ResponseBody
	public JSONObject idCheck(@RequestParam String id, HttpServletResponse response) {
		response.setContentType("text/html;charset=utf-8");
//		System.out.println(id);
		JSONObject jo = new JSONObject();
		boolean exist = service.getMember(id) == null;
		if (exist) {
			jo.put("bool", true);
			jo.put("str", "사용가능");

		} else {
			jo.put("bool", false);
			jo.put("str", "중복아이디");
		}
		return jo;
	}

	@PostMapping(value = "/member/join")
	public String join(Member m) {
		System.out.println(m);

		service.addMember(m);
		return "redirect:/member/loginForm";
	}

	@PostMapping(value = "/member/loginChk")
	@ResponseBody
	public JSONObject loginChk(@RequestParam String id, @RequestParam String pwd) {
		JSONObject jo = new JSONObject();
		Member m = service.getMember(id);
		if (m == null || !m.getUser_pwd().equals(pwd)) {
			jo.put("res", "fail");
		} else {
			jo.put("res", "ok");
		}
		return jo;
	}

//	
	@PostMapping(value = "/member/login")
//	@ResponseBody
	public ModelAndView login(HttpServletRequest req, String user_id, String user_pwd, String refer) {
//		@RequestParam(value="refer", required=false) 

		System.out.println(refer);
		ModelAndView mav = new ModelAndView();

		Member m = service.getMember(user_id);
		System.out.println("login() : " + m + "\n");

		if (m != null && m.getUser_pwd().equals(user_pwd)) {
			HttpSession session = req.getSession();
			session.setAttribute("user_id", m.getUser_id());
			session.setAttribute("user_type", m.getUser_type());

			String destination = "/member/main";

			if (refer != "") {
				refer = refer.split("localhost:....")[1];
				System.out.println(refer);
				destination = refer;
			}
			System.out.println("로그인 확인" + m.getUser_id());
			mav.setViewName("redirect:" + destination);

			if (m.getUser_type() == 2) {
				mav.setViewName("redirect:/member/list");
			}

		} else if (req.getSession(false) != null) {
			if (req.getSession(false).getAttribute("user_id") != null) {
				mav.setViewName("redirect:/member/main");
			} else {
				mav.setViewName("redirect:/member/loginForm");
			}
		}
		return mav;
	}

	@RequestMapping(value = "/member/main")
	public String main(HttpServletRequest req) {

		HttpSession session = req.getSession(false);
		String id = (String) session.getAttribute("user_id");
		Member m = service.getMember(id);
		req.setAttribute("m", m);

//		String vi = sessionChk(req);
		return req.getRequestURI();
	}

	@RequestMapping(value = "/member/passwordChk")
	public void pwdChk() {
	}

	@PostMapping(value = "/member/pwdChk")
	@ResponseBody
	public JSONObject pwdChk(HttpServletRequest req, @RequestParam("pwd") String user_pwd) {
		HttpSession session = req.getSession(false);
		JSONObject jo = new JSONObject();
		String id = (String) session.getAttribute("user_id");
		Member m = service.getMember(id);
		if (m.getUser_pwd().equals(user_pwd)) {
			jo.put("res", "ok");

		} else {
			jo.put("res", "fail");
		}
		return jo;
	}

	@RequestMapping(value = "/member/editForm")
	public ModelAndView editForm(HttpServletRequest req) {
//		System.out.println("editForm 확인");
		ModelAndView mav = new ModelAndView("/member/editForm");
		HttpSession session = req.getSession(false);
		String id = (String) session.getAttribute("user_id");
		Member m = service.getMember(id);
		mav.addObject("m", m);
//		System.out.println(m);
		return mav;
	}

	@PostMapping(value = "/member/edit")
	public String edit(Member m) {
		service.editMember(m);
		return "redirect:/member/main";
	}

	@RequestMapping(value = "/member/logout")
	public String logout(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		String id = (String) session.getAttribute("user_id");
		System.out.println(id + " 로그아웃");
		session.removeAttribute("user_id");
		session.invalidate();
		return "redirect:/";
	}

	@RequestMapping(value = "/member/out")
	public String out(HttpServletRequest req, @RequestParam(value = "id", required = false) String user_id) {
		System.out.println(user_id + " 아이디 확인");
		HttpSession session = req.getSession(false);
		String id = (String) session.getAttribute("user_id");
		if (user_id == null) {
			System.out.println(id + " 회원 탈퇴");
			service.delMember(id);
			session.removeAttribute("user_id");
			session.invalidate();

		} else {
			System.out.println(user_id + " 관리자 권한으로 회원 탈퇴");
			service.delMember(user_id);
		}

		return "redirect:/member/loginForm";
	}

	@GetMapping(value = "/member/list")
	public String listv(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		String id = (String) session.getAttribute("user_id");
		Member m = service.getMember(id);
		int type = m.getUser_type();
		if (type != 2) {
			return "redirect:/member/main";
		} else {
			return req.getRequestURI();
		}
	}

	@SuppressWarnings("unchecked")
	@PostMapping(value = "/member/list")
	@ResponseBody
	public JSONArray list() {
		JSONArray jarray = new JSONArray();
		ArrayList<Member> ml = service.list();
		for (Member i : ml) {
			jarray.add(i);
		}

		System.out.println();
		return jarray;
	}

	@GetMapping(value = "/member/findPwd")
	public String findp(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		String id = (String) session.getAttribute("user_id");
		if (id != null) {
			return "redirect:/member/main";
		} else {
			return req.getRequestURI();
		}
	}

	@PostMapping(value = "/member/findPwd")
	public ModelAndView findPwd(String user_id, Date birth, String email) {
		ModelAndView mav = new ModelAndView();

		Member m = service.getMember(user_id);

		if (m == null) {
			System.out.println("아이디 없음");
			mav.setViewName("/member/findPwd");
			mav.addObject("error", "아이디를 확인해주세요.");
		} else if (m.getUser_email().equals(email) || m.getUser_birth().equals(birth)) {
			mav.addObject("user_id", user_id);
			mav.setViewName("/member/changePwd");

		} else {
			mav.setViewName("/member/findPwd");
			mav.addObject("error", "입력값을 확인해주세요.");
		}
		return mav;
	}

	@GetMapping(value = "/member/changePwd")
	public void changePwdPage() {
	}

	@PostMapping(value = "/member/changePwd")
	public String changePwd(Member m) {
		System.out.println("changePwd");
		service.changePassword(m);
		System.out.println("changePwd2");
		return "redirect:/member/loginForm";
	}

	@RequestMapping("/member/rate")
	public String score(@RequestParam String user_id, @RequestParam(value = "score") int user_score,
			@RequestParam int alram_num) {
		service.editUserScore(user_id, user_score);
		Alram a = aService.getAlram(alram_num);
		a.setAlram_type(6);
		aService.editAlram(a);
		return "redirect:/member/main";
	}

//	@PostMapping(value="/member/changePwd")
//	public String changePwd(Member) {
//		HttpSession session = req.getSession(false);
//		String id = (String)session.getAttribute("user_id");
//		Member m = service.getMember(id);
//		m.setUser_pwd(user_pwd);
//		service.editMember(m);
//	}

//	css 연결용---------------------------------------------
	@RequestMapping(value = "/member/loginForm2")
	public void loginForm2() {
	}

}
