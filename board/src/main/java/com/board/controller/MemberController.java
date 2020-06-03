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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

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

		// 해당하는 정보가 없을때
		if (login == null) {
			model.addAttribute("msg", "falseID");
			return "redirect:/member/login";
		} else {
			// 암호화된 비밀번호 비교
			boolean matchPW = pwdEncoder.matches(vo.getmPW(), login.getmPW());
			// 비밀번호 일치
			if (matchPW) {
				session.setAttribute("session", login);
				return "redirect:/";
			} else {
				session.setAttribute("session", null);
				model.addAttribute("msg", "falsePW");
				return "redirect:/member/login";
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
		if (idCheck != null) {
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
		if (nicknameCheck != null) {
			result = 1;
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/pwCheck", method = RequestMethod.POST)
	public int postPwCheck(HttpServletRequest req) throws Exception {
		String mID = req.getParameter("mID");
		String curPW = req.getParameter("curPW");
		System.out.println(curPW);
		
		MemberVO pwCheck = service.pwCheck(mID);
		System.out.println(pwCheck.getmPW());
		int result = 0;
		if (pwCheck != null) {
			boolean matchPW = pwdEncoder.matches(curPW, pwCheck.getmPW());
			if(matchPW) {
				result = 1;
			}
		}
		return result;
	}

	@RequestMapping(value = "/profile", method = RequestMethod.GET)
	public void getProfile() throws Exception {
		
	}
	
	@RequestMapping(value = "/profile", method = RequestMethod.POST)
	public String postProfile(MemberVO vo, MultipartHttpServletRequest request, HttpServletRequest req) throws Exception {

		MultipartFile file = request.getFile("Img");
		if (file.getSize() != 0) {
			service.profile(vo, file);
		} else {
			service.profile(vo);
		}
		
		MemberVO login = service.login(vo);
		HttpSession session = req.getSession();
		session.setAttribute("session", login);
		
		return "redirect:/";
	}
	
	@RequestMapping(value = "/password", method = RequestMethod.GET)
	public void getPassword() throws Exception {
		
	}
	
	@RequestMapping(value = "/password", method = RequestMethod.POST)
	public String postPassword(MemberVO vo, HttpSession session) throws Exception {
		vo.setmPW(pwdEncoder.encode(vo.getmPW()));
		service.password(vo);
		
		session.invalidate();
		
		return "redirect:/member/login";
	}

}