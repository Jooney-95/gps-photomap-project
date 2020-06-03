package com.board.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.board.domain.MemberVO;
import com.board.service.MemberService;

@Controller
@RequestMapping("/member/*")
public class MemberController {

	@Inject
	MemberService service;

	@Inject
	BCryptPasswordEncoder pwdEncoder;

	@RequestMapping(value = "/fRegister", method = RequestMethod.GET)
	public void getFRegister() {

	}

	@RequestMapping(value = "/fRegister", method = RequestMethod.POST)
	public String postFRegister() throws Exception {

		return "redirect:/member/sRegister";
	}

	@RequestMapping(value = "/sRegister", method = RequestMethod.GET)
	public void getSRegister() {

	}

	@RequestMapping(value = "/sRegister", method = RequestMethod.POST)
	public String postSRegister(MemberVO vo) throws Exception {

		vo.setmPW(pwdEncoder.encode(vo.getmPW()));
		service.register(vo);

		return "redirect:/member/tRegister";
	}

	@RequestMapping(value = "/tRegister", method = RequestMethod.GET)
	public void getTRegister() {

	}

	@RequestMapping(value = "/tRegister", method = RequestMethod.POST)
	public String postTRegister() {
		return "redirect:/member/login";
	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public void getLogin() {

	}

	// 로그인
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String postLogin(MemberVO vo, HttpServletRequest req, Model model) throws Exception {
		HttpSession session = req.getSession();
		MemberVO login = service.login(vo);
		System.out.println(login);

		// 해당하는 정보가 없을때
		if (login == null) {
			model.addAttribute("msg", "falseID");
			System.out.println("아이디 없음");
			return "/member/login";
		} else {
			// 암호화된 비밀번호 비교
			boolean matchPW = pwdEncoder.matches(vo.getmPW(), login.getmPW());
			// 비밀번호 일치
			if (matchPW) {
				session.setAttribute("member", login);
				System.out.println("로그인 성공");
				return "redirect:/";
			} else {
				session.setAttribute("member", null);
				model.addAttribute("msg", "falsePW");
				System.out.println("비번 오류");
				return "/member/login";
			}
		}

	}

	// 로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) throws Exception {

		session.invalidate();

		return "redirect:/";
	}
	
	@ResponseBody
	@RequestMapping(value = "/idCheck", method = RequestMethod.POST)
	public int postIdCheck(HttpServletRequest req) throws Exception {
		String mID = req.getParameter("mID");
		MemberVO idCheck = service.idCheck(mID);
		int result = 0;
		if(idCheck != null) {
			result = 1;
		}
		return result;
	}
	@ResponseBody
	@RequestMapping(value = "/nicknameCheck", method = RequestMethod.POST)
	public int postNicknameCheck(HttpServletRequest req) throws Exception {
		String mNickname = req.getParameter("mNickname");
		MemberVO nicknameCheck = service.nicknameCheck(mNickname);
		int result = 0;
		if(nicknameCheck != null) {
			result = 1;
		}
		return result;
	}

}