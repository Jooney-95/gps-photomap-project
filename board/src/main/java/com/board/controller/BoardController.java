package com.board.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

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
import com.board.domain.LikeVO;
import com.board.domain.MemberVO;
import com.board.domain.Page;
import com.board.domain.TpVO;
import com.board.service.BoardService;
import com.board.service.FileService;
import com.board.service.MemberService;
import com.board.service.TpService;

@Controller
@RequestMapping("/board/*")
public class BoardController {

	@Inject
	BoardService service;

	@Inject
	FileService fileService;

	@Inject
	TpService tpService;
	
	@Inject
	MemberService memberService;

	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public void getWrite() throws Exception {

	}

	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String postWriter(BoardVO vo, MultipartHttpServletRequest request) throws Exception {
		vo.setTitle(vo.getTitle().trim());
		
		int fileBno = service.write(vo);

		List<MultipartFile> file = request.getFiles("filesList");
		if (file.get(0).getSize() != 0) {
			fileService.write(file, fileBno);
		}

		return "redirect:/board/modify?bno=" + fileBno;
	}

	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public void getView(@RequestParam("bno") int bno, Model model) throws Exception {

		BoardVO vo = service.view(bno);
		MemberVO mVo = memberService.memberVO(vo.getWriter());
		service.hitViewCnt(bno);
		
		List<FileVO> list = null;
		List<TpVO> tp = null;
		
		list = fileService.viewFile(bno);
		tp = tpService.viewTp(bno);
		
		model.addAttribute("view", vo);
		model.addAttribute("list", list);
		model.addAttribute("tp", tp);
		model.addAttribute("member", mVo);

	}

	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public void getModify(@RequestParam("bno") int bno, Model model) throws Exception {
		
		BoardVO vo = service.view(bno);
		
		List<FileVO> list = null;
		List<TpVO> tp = null;
		
		list = fileService.viewFile(bno);
		tp = tpService.viewTp(bno);
		
		model.addAttribute("view", vo);
		model.addAttribute("list", list);
		model.addAttribute("tp", tp);
		
	}

	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String postModify(MultipartHttpServletRequest request, HttpServletRequest req, BoardVO vo) throws Exception {
		vo.setTitle(vo.getTitle().trim());
		service.modify(vo);

		int fileBno = Integer.parseInt(req.getParameter("bno"));
		String[] str_id = req.getParameterValues("id");
		String[] time = req.getParameterValues("time");
		String[] delete = req.getParameterValues("del");
		String[] latitude = req.getParameterValues("lat");
		String[] longitude = req.getParameterValues("lon");
		String[] content = req.getParameterValues("content");

		if (str_id != null) {
			TpVO tp = new TpVO();
			tpService.reset(str_id);
			fileService.modifyFile(str_id, latitude, longitude, time, content);
			
			for (int i = Integer.parseInt(str_id[0]); i <= Integer.parseInt(str_id[str_id.length - 1]); i++) {
				if (req.getParameterValues(Integer.toString(i)) != null) {
					for (int j = 0; j < req.getParameterValues(Integer.toString(i)).length; j++) {
						tp.setTpBno(i);
						tp.setTp(req.getParameterValues(Integer.toString(i))[j]);
						tp.setFileBno(fileBno);
						tpService.set(tp);

					}
				}
			}
		}
		if (delete != null) {
			fileService.deleteFile(delete);
		}

		List<MultipartFile> file = request.getFiles("filesList");
		if (file.get(0).getSize() != 0) {
			fileService.write(file, fileBno);
			return "redirect:/board/modify?bno=" + vo.getBno();
		} else {
			return "redirect:/board/view?bno=" + vo.getBno();
		}
	}

	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String getDelete(@RequestParam("bno") int bno) throws Exception {
		service.delete(bno);

		return "redirect:/board/listPageSearch?num=1";
	}

	// 게시물 목록 + 페이징 추가 + 검색
	@RequestMapping(value = "/listPageSearch", method = RequestMethod.GET)
	public void getListPageSearch(Model model, @RequestParam("num") int num,
			@RequestParam(value = "searchType", required = false, defaultValue = "title") String searchType,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword) throws Exception {

		Page page = new Page();

		page.setNum(num);
		page.setCount(service.count());

		List<BoardVO> list = null;
		// list = service.listPage(page.getDisplayPost(), page.getPostNum());
		list = service.listPageSearch(page.getDisplayPost(), page.getPostNum(), searchType, keyword);

		List<FileVO> fList = new ArrayList<FileVO>();
		List<ArrayList<FileVO>> fileList = new ArrayList<ArrayList<FileVO>>();
		MemberVO m = new MemberVO();
		List<MemberVO> mList = new ArrayList<MemberVO>();

		// 글 번호에 해당하는 이미지 받아오기
		for (BoardVO vo : list) {
			fList = fileService.viewFile(vo.getBno());
			m = memberService.memberVO(vo.getWriter());
			fileList.add((ArrayList<FileVO>) fList);
			mList.add(m);
		}

		model.addAttribute("fileList", fileList);
		model.addAttribute("list", list);
		model.addAttribute("page", page);
		model.addAttribute("select", num);
		model.addAttribute("member", mList);

	}
	
	@ResponseBody
	@RequestMapping(value = "/likeClick", method = RequestMethod.POST)
	public void postLikeClick(HttpServletRequest req) throws Exception {
		int userID = Integer.parseInt(req.getParameter("userID"));
		int tblBno = Integer.parseInt(req.getParameter("tblBno"));
		
		LikeVO vo = new LikeVO();
		vo.setTblBno(tblBno);
		vo.setUserID(userID);
		LikeVO likeVO = service.likeCheck(vo);
		
		
		if (likeVO == null) {
			service.likeUp(vo);
			service.likeUpTbl(vo);
		} else {
			service.likeDown(vo);
			service.likeDownTbl(vo);
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/likeCount", method = RequestMethod.POST)
	public int postLikeCount(HttpServletRequest req) throws Exception {
		int tblBno = Integer.parseInt(req.getParameter("tblBno"));

		int likeCount = service.likeCnt(tblBno);

		return likeCount;

	}
	
	@ResponseBody
	@RequestMapping(value = "/likeCheck", method = RequestMethod.POST)
	public int postLikeCheck(HttpServletRequest req) throws Exception {
		int userID = Integer.parseInt(req.getParameter("userID"));
		int tblBno = Integer.parseInt(req.getParameter("tblBno"));
		int check = 0;
		
		LikeVO vo = new LikeVO();
		vo.setTblBno(tblBno);
		vo.setUserID(userID);
		LikeVO likeVO = service.likeCheck(vo);
		
		
		if (likeVO == null) {
		} else {
			check = 1;
		}
		
		return check;
	}
	
}