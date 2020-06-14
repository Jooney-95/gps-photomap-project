package com.board.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.board.domain.BoardVO;
import com.board.domain.FileVO;
import com.board.domain.FollowVO;
import com.board.domain.MemberVO;
import com.board.domain.Page;
import com.board.service.BoardService;
import com.board.service.FileService;
import com.board.service.MemberService;

@Controller
@RequestMapping("/member/*")
public class MemberController {

	@Inject
	MemberService service;
	
	@Inject
	BoardService boardService;

	@Inject
	FileService fileService;
	
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
		
		MemberVO pwCheck = service.pwCheck(mID);
		
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
	
	@RequestMapping(value = "/myPage", method = RequestMethod.GET)
	public void getMyPage(Model model, @RequestParam("userID") int userID, @RequestParam("num") int num,
			@RequestParam(value = "searchType", required = false, defaultValue = "title") String searchType,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword) throws Exception {
		
		Page page = new Page();
		int count = boardService.count(userID);
		
		page.setNum(num);
		page.setCount(count);
		
		List<BoardVO> list = null;
		
		list = boardService.MyPageSearch(userID, page.getDisplayPost(), page.getPostNum(), searchType, keyword);

		
		
		List<FollowVO> follow = new ArrayList<FollowVO>();
		List<FollowVO> following = new ArrayList<FollowVO>();
		follow = service.userFollow(userID);
		following = service.userFollowing(userID);
		
		int countFollow = follow.size();
		int countFollowing = following.size();
		
		List<FileVO> fList = new ArrayList<FileVO>();
		List<ArrayList<FileVO>> fileList = new ArrayList<ArrayList<FileVO>>();
		MemberVO m = new MemberVO();
		List<MemberVO> mList = new ArrayList<MemberVO>();

		// 글 번호에 해당하는 이미지 받아오기
		for (BoardVO vo : list) {
			fList = fileService.viewFile(vo.getBno());
			m = service.memberVO(vo.getWriter());
			fileList.add((ArrayList<FileVO>) fList);
			mList.add(m);
		}

		model.addAttribute("fileList", fileList);
		model.addAttribute("list", list);
		model.addAttribute("page", page);
		model.addAttribute("select", num);
		model.addAttribute("member", mList);
		model.addAttribute("userID", userID);
		model.addAttribute("count", count);
		model.addAttribute("follow", follow);
		model.addAttribute("following", following);
		model.addAttribute("countFollow", countFollow);
		model.addAttribute("countFollowing", countFollowing);
	}

	@ResponseBody
	@RequestMapping(value = "/followingCheck", method = RequestMethod.POST)
	public int postFollowCheck(HttpServletRequest req) throws Exception {
		int sessionID = Integer.parseInt(req.getParameter("sessionID"));
		int userID = Integer.parseInt(req.getParameter("userID"));
		
		FollowVO suVo = new FollowVO();
		suVo.setUserID(sessionID);
		suVo.setFollowing(userID);
		
		FollowVO usVo = new FollowVO();
		usVo.setUserID(userID);
		usVo.setFollowing(sessionID);
		
		FollowVO suCheck = service.followingCheck(suVo);
		FollowVO usCheck = service.followingCheck(usVo);
		
		int result = 0;
		if (suCheck == null && usCheck != null) {
			result = 2;
		}
		else if(suCheck != null) {
			result = 1;
		}

		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/followClick", method = RequestMethod.POST)
	public void postFollowClick(HttpServletRequest req) throws Exception {
		int sessionID = Integer.parseInt(req.getParameter("sessionID"));
		int userID = Integer.parseInt(req.getParameter("userID"));
		
		FollowVO suVo = new FollowVO();
		suVo.setUserID(sessionID);
		suVo.setFollowing(userID);
		
		FollowVO usVo = new FollowVO();
		usVo.setUserID(userID);
		usVo.setFollowing(sessionID);
		
		FollowVO suCheck = service.followingCheck(suVo);
		FollowVO usCheck = service.followingCheck(usVo);
		
		if (suCheck == null && usCheck == null) {
			service.follow(suVo);
		}
		else if(suCheck != null && usCheck == null) {
			service.unFollow(suVo);
		}
		else if(suCheck == null && usCheck != null) {
			service.follow(suVo);
			service.fforf(suVo);
		}
		else if(suCheck != null && usCheck != null) {
			service.unFollow(suVo);
			service.unFforf(usVo);
		}
		
	}
}