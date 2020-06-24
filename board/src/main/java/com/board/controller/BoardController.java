package com.board.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import com.board.domain.ToVO;
import com.board.domain.TpVO;
import com.board.service.BoardService;
import com.board.service.FileService;
import com.board.service.MemberService;
import com.board.service.TpService;
import com.google.gson.Gson;

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
	public void getWrite(HttpSession session, Model model) throws Exception {
		
	}

	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public void postWriter() throws Exception {

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

	@RequestMapping(value = "/map", method = RequestMethod.GET)
	public void map() throws Exception {
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
	public void postModify() throws Exception {
		
	}

	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String getDelete(@RequestParam("bno") int bno) throws Exception {
		service.delete(bno);
		fileService.deleteFileBno(bno);
		tpService.deleteFileBno(bno);
		return "redirect:/board/listPageSearch?num=1";
	}

	// 占쌉시뱄옙 占쏙옙占� + 占쏙옙占쏙옙징 占쌩곤옙 + 占싯삼옙
	@RequestMapping(value = "/listPageSearch", method = RequestMethod.GET)
	public void getListPageSearch(Model model, HttpSession session, @RequestParam("num") int num,
			@RequestParam(value = "searchType", required = false, defaultValue = "title") String searchType,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword) throws Exception {

		if (session != null) {

		}
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
		SimpleDateFormat format1;
		format1 = new SimpleDateFormat("yyyy-MM-dd");

		
		// 占쏙옙 占쏙옙호占쏙옙 占쌔댐옙占싹댐옙 占싱뱄옙占쏙옙 占쌨아울옙占쏙옙
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

		ToVO toVO = new ToVO();
		
		LikeVO likeVO = toVO.likeVO(tblBno, userID);
		LikeVO likeCheck = service.likeCheck(likeVO);

		if (likeCheck == null) {
			service.likeUp(likeVO);
			service.likeUpTbl(likeVO);
		} else {
			service.likeDown(likeVO);
			service.likeDownTbl(likeVO);
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

		
		ToVO toVO = new ToVO();
		LikeVO likeVO = toVO.likeVO(tblBno, userID);
		LikeVO likeCheck = service.likeCheck(likeVO);

		if (likeCheck == null) {
		} else {
			check = 1;
		}

		return check;
	}

	@ResponseBody
	@RequestMapping(value = "/beforeunload", method = RequestMethod.POST)
	public void postBeforeunload(HttpServletRequest req) throws Exception {
		int userID = Integer.parseInt(req.getParameter("userID"));

			fileService.beforeunload(userID);
	}

	@ResponseBody
	@RequestMapping(value = "/imgUpload", method = RequestMethod.POST)
	public String postImgUpload(HttpServletRequest req, MultipartHttpServletRequest request) throws Exception {
		int userID = Integer.parseInt(req.getParameter("userID"));
		List<MultipartFile> file = request.getFiles("imgFileList");

		fileService.imgUpload(file, userID);
		List<FileVO> fVo = fileService.imgSelect(userID);

		Gson gson = new Gson();
		String jsonPlace = gson.toJson(fVo);

		return jsonPlace;
	}

	@ResponseBody
	@RequestMapping(value = "/writeClick", method = RequestMethod.POST)
	public String postWriteClick(HttpServletRequest req) throws Exception {
		int userID = Integer.parseInt(req.getParameter("userID"));
		int pNum = Integer.parseInt(req.getParameter("pNum"));
		String title = req.getParameter("title");
		String del[] = req.getParameterValues("del");
		int size = Integer.parseInt(req.getParameter("size"));

		ToVO toVO = new ToVO();

		BoardVO boardVO = toVO.boardVO(title, userID, pNum);

		int fileBno = service.write(boardVO);

		if (del.length > 1) {
			fileService.deleteFile(del);
		}

		if (size > 0) {
			String id[] = req.getParameterValues("id");
			String lat[] = req.getParameterValues("lat");
			String lon[] = req.getParameterValues("lon");
			String time[] = req.getParameterValues("time");
			String content[] = req.getParameterValues("content");
			String tp[] = req.getParameterValues("tp");
	
	
			tpService.reset(id);
	
			for (int i = 0; i < id.length; i++) {
				if (tp[i].length() != 0) {
					String[] tp_str = tp[i].split(",");
					for (int j = 0; j < tp_str.length; j++) {
						TpVO tpVO = toVO.tpVO((id[i]), tp_str[j], fileBno);
						tpService.set(tpVO);
					}
				}
			}
			
			fileService.writeClick(toVO.writeClick(fileBno, id, lat, lon, time, content, size));
			
			if(id.length > 49) {
				String del_id[] = new String[id.length-50];
				for(int i = 50; i < id.length; i++) {
					del_id[i-50] = id[i];
				}
				fileService.deleteFile(del_id);
			}
		}
		

		return "/board/view?bno=" + fileBno;
	}
	
	@ResponseBody
	@RequestMapping(value = "/modifyClick", method = RequestMethod.POST)
	public String postModifyClick(HttpServletRequest req) throws Exception {
		int userID = Integer.parseInt(req.getParameter("userID"));
		int pNum = Integer.parseInt(req.getParameter("pNum"));
		int bno = Integer.parseInt(req.getParameter("bno"));
		int size = Integer.parseInt(req.getParameter("size"));
		
		String title = req.getParameter("title");
		String del[] = req.getParameterValues("del");
		
		ToVO toVO = new ToVO();
		
		BoardVO boardVO = toVO.boardVO(title, userID, pNum, bno);

		service.modify(boardVO);

		if (del.length > 1) {
			fileService.deleteFile(del);
		}

		if (size > 0) {
			String id[] = req.getParameterValues("id");
			String lat[] = req.getParameterValues("lat");
			String lon[] = req.getParameterValues("lon");
			String time[] = req.getParameterValues("time");
			String content[] = req.getParameterValues("content");
			String tp[] = req.getParameterValues("tp");
	
			tpService.reset(id);
	
			for (int i = 0; i < id.length; i++) {
				if (tp[i].length() != 0) {
					String[] tp_str = tp[i].split(",");
					for (int j = 0; j < tp_str.length; j++) {
						TpVO tpVO = toVO.tpVO((id[i]), tp_str[j], bno);
						tpService.set(tpVO);
					}
				}
			}
			
			fileService.writeClick(toVO.writeClick(bno, id, lat, lon, time, content, size));
			
			if(id.length > 49) {
				String del_id[] = new String[id.length-50];
				for(int i = 50; i < id.length; i++) {
					del_id[i-50] = id[i];
				}
				fileService.deleteFile(del_id);
			}
		}
		

		return "/board/view?bno=" + bno;
	}

}