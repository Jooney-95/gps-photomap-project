package com.board.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.board.domain.MemberVO;
import com.board.service.MemberService;

@Controller
@RequestMapping("/member/*")
public class MemberController {

	@Inject
	MemberService service;

	@Inject
	BCryptPasswordEncoder pwdEncoder;

	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public void getRegister() {

	}
	// 회원가입
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public void postRegister(MemberVO vo) throws Exception {
		vo.setmPW(pwdEncoder.encode(vo.getmPW()));
		service.register(vo);
	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public void getLogin() {

	}
	// 로그인
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public void postLogin(MemberVO vo, HttpServletRequest req, RedirectAttributes rttr) throws Exception {
		HttpSession session = req.getSession();
		MemberVO login = service.login(vo);
		System.out.println(login);
		
		// 해당하는 정보가 없을때
		if (login == null) {
			rttr.addFlashAttribute("msg", "falseID");
			System.out.println("아이디 없음");
		} else {
			// 암호화된 비밀번호 비교
			boolean matchPW = pwdEncoder.matches(vo.getmPW(), login.getmPW());
			// 비밀번호 일치
			if (matchPW) {
				session.setAttribute("member", login);
				System.out.println("로그인 성공");
			} else {
				session.setAttribute("member", null);
				rttr.addFlashAttribute("msg", "falsePW");
				System.out.println("비번 오류");
			}
		}
	}
	
	// 로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String getLogout(HttpSession session) throws Exception{
		session.invalidate();
		
		return "/member/login";
	}
}
