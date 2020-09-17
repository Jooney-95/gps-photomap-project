package com.board.controller;

import java.util.ArrayList;
import java.util.HashMap;
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
import com.board.domain.FollowVO;
import com.board.domain.LikeImgVO;
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
		List<LikeImgVO> likeImg = null;

		list = fileService.viewFile(bno);
		tp = tpService.viewTp(bno);
		likeImg = fileService.selectLikeImg(bno);

		model.addAttribute("view", vo);
		model.addAttribute("list", list);
		model.addAttribute("tp", tp);
		model.addAttribute("member", mVo);
		model.addAttribute("likeImg", likeImg);

	}

	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public void getModify(@RequestParam("bno") int bno, Model model) throws Exception {

		BoardVO vo = service.view(bno);

		List<LikeImgVO> likeImg = null;
		// List<FileVO> list = null;
		// List<TpVO> tp = null;

		// list = fileService.viewFile(bno);
		// tp = tpService.viewTp(bno);
		likeImg = fileService.selectLikeImg(bno);

		model.addAttribute("view", vo);
		model.addAttribute("likeImg", likeImg);
		// model.addAttribute("list", list);
		// model.addAttribute("tp", tp);

	}

	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public void postModify() throws Exception {

	}

	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String getDelete(@RequestParam("bno") int bno) throws Exception {
		service.delete(bno);
		fileService.deleteFileBno(bno);
		tpService.deleteFileBno(bno);
		return "redirect:/board/main";
	}

	// 占쌉시뱄옙 占쏙옙占� + 占쏙옙占쏙옙징 占쌩곤옙 + 占싯삼옙
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public void getMain() throws Exception {

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
	@RequestMapping(value = "/writeFile", method = RequestMethod.POST)
	public String postWriteFile(HttpServletRequest req, MultipartHttpServletRequest request) throws Exception {
		int userID = Integer.parseInt(req.getParameter("userID"));
		List<MultipartFile> file = request.getFiles("imgFileList");

		fileService.imgUpload(file, userID);
		List<FileVO> fVo = fileService.writeFile(userID);

		Gson gson = new Gson();
		String jsonPlace = gson.toJson(fVo);

		return jsonPlace;
	}

	@ResponseBody
	@RequestMapping(value = "/modifyFile", method = RequestMethod.POST)
	public HashMap<String, Object> postModifyFile(HttpServletRequest req, MultipartHttpServletRequest request)
			throws Exception {
		int userID = Integer.parseInt(req.getParameter("userID"));
		int bno = Integer.parseInt(req.getParameter("bno"));

		List<MultipartFile> file = request.getFiles("imgFileList");

		HashMap<String, Object> map = new HashMap<String, Object>();

		fileService.imgUpload(file, userID);
		List<FileVO> fVo = fileService.modifyFile(userID, bno);

		List<TpVO> tp = null;
		tp = tpService.viewTp(bno);

		Gson gson = new Gson();
		String JsonFile = gson.toJson(fVo);
		String JsonTp = gson.toJson(tp);

		map.put("file", JsonFile);
		map.put("tp", JsonTp);

		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/loadImg", method = RequestMethod.POST)
	public HashMap<String, Object> getLoadImg(HttpServletRequest req) throws Exception {
		int userID = Integer.parseInt(req.getParameter("userID"));
		int bno = Integer.parseInt(req.getParameter("bno"));

		HashMap<String, Object> map = new HashMap<String, Object>();

		List<FileVO> fVo = fileService.modifyFile(userID, bno);
		List<TpVO> tp = tpService.viewTp(bno);
		List<LikeImgVO> likeImgVO = fileService.selectLikeImg(bno);

		Gson gson = new Gson();
		String JsonFile = gson.toJson(fVo);
		String JsonTp = gson.toJson(tp);
		String JsonLikeImg = gson.toJson(likeImgVO);

		map.put("file", JsonFile);
		map.put("tp", JsonTp);
		map.put("likeImg", JsonLikeImg);

		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/writeClick", method = RequestMethod.POST)
	public String postWriteClick(HttpServletRequest req) throws Exception {
		int size = Integer.parseInt(req.getParameter("size"));
		if (size > 0) {
			int userID = Integer.parseInt(req.getParameter("userID"));
			int pNum = Integer.parseInt(req.getParameter("pNum"));
			String title = req.getParameter("title");
			String kate = req.getParameter("kate");
			String del[] = req.getParameterValues("del");

			ToVO toVO = new ToVO();
			System.out.println(kate);
			BoardVO boardVO = toVO.boardVO(title, userID, pNum, kate);

			int fileBno = service.write(boardVO);

			if (del != null) {
				fileService.deleteFile(del);
			}

			String id[] = req.getParameterValues("id");
			String lat[] = req.getParameterValues("lat");
			String lon[] = req.getParameterValues("lon");
			String loc[] = req.getParameterValues("loc");
			String time[] = req.getParameterValues("time");
			String content[] = req.getParameterValues("content");
			String tp[] = req.getParameterValues("tp");
			String likeImgs[] = req.getParameterValues("likeImgs");

			if (likeImgs != null) {
				fileService.deleteLikeImgs(fileBno);
				fileService.likeImgs(toVO.likeImgVO(likeImgs, fileBno));
			}

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

			fileService.writeClick(toVO.writeClick(fileBno, id, lat, lon, loc, time, content, size));

			if (id.length > 49) {
				String del_id[] = new String[id.length - 50];
				for (int i = 50; i < id.length; i++) {
					del_id[i - 50] = id[i];
				}
				fileService.deleteFile(del_id);
			}

			return "/board/view?bno=" + fileBno;
		}
		System.out.println("이미지 없음");
		return "/board/write";
	}

	@ResponseBody
	@RequestMapping(value = "/modifyClick", method = RequestMethod.POST)
	public String postModifyClick(HttpServletRequest req) throws Exception {
		int userID = Integer.parseInt(req.getParameter("userID"));
		int pNum = Integer.parseInt(req.getParameter("pNum"));
		int bno = Integer.parseInt(req.getParameter("bno"));
		int size = Integer.parseInt(req.getParameter("size"));
		String kate = req.getParameter("kate");
		String title = req.getParameter("title");
		String del[] = req.getParameterValues("del");

		ToVO toVO = new ToVO();

		BoardVO boardVO = toVO.boardVO(title, userID, pNum, bno, kate);

		service.modify(boardVO);

		if (del != null) {
			fileService.deleteFile(del);
		}

		if (size > 0) {
			String id[] = req.getParameterValues("id");
			String lat[] = req.getParameterValues("lat");
			String lon[] = req.getParameterValues("lon");
			String loc[] = req.getParameterValues("loc");
			String time[] = req.getParameterValues("time");
			String content[] = req.getParameterValues("content");
			String tp[] = req.getParameterValues("tp");
			String likeImgs[] = req.getParameterValues("likeImgs");

			fileService.deleteLikeImgs(bno);
			if (likeImgs != null) {
				fileService.likeImgs(toVO.likeImgVO(likeImgs, bno));
			}

			tpService.deleteFileBno(bno);
			for (int i = 0; i < id.length; i++) {
				if (tp[i].length() != 0) {
					String[] tp_str = tp[i].split(",");
					for (int j = 0; j < tp_str.length; j++) {
						TpVO tpVO = toVO.tpVO((id[i]), tp_str[j], bno);
						tpService.set(tpVO);
					}
				}
			}

			fileService.writeClick(toVO.writeClick(bno, id, lat, lon, loc, time, content, size));

			if (id.length > 49) {
				String del_id[] = new String[id.length - 50];
				for (int i = 50; i < id.length; i++) {
					del_id[i - 50] = id[i];
				}
				fileService.deleteFile(del_id);
			}
		}

		return "/board/view?bno=" + bno;
	}

	@ResponseBody
	@RequestMapping(value = "/getPage", method = RequestMethod.POST)
	public HashMap<String, Object> getPage(HttpServletRequest req, HttpSession session) throws Exception {
		int pageNum = Integer.parseInt(req.getParameter("pageNum"));
		String flag = req.getParameter("flag");
		String kate[] = req.getParameterValues("kate");
		System.out.println(kate);

		MemberVO login = (MemberVO) session.getAttribute("session");

		Page page = new Page();

		page.setNum(pageNum);
		page.setCount(service.count());

		List<BoardVO> list = null;

		System.out.println("flag : " + flag);

		if (login != null) {
			System.out.println("로그인 했을때 실행");
			List<FollowVO> fforfList = null;
			fforfList = memberService.fforfList(login.getId());
			if (fforfList.size() > 0) {
				System.out.println("서로이웃이 있을때 실행");
				list = service.getPage(page.getDisplayPost(), page.getPostNum(), flag, kate, fforfList);
			} else {
				if (!flag.equals("fol")) {
					System.out.println("서로이웃이 없고 이웃게시물이 아닐때 실행");
					list = service.getPage(page.getDisplayPost(), page.getPostNum(), flag, kate);
				}
			}
		} else {
			if (!flag.equals("fol")) {
				System.out.println("로그인 안하고 이웃게시물이 아닐때 실행");
				list = service.getPage(page.getDisplayPost(), page.getPostNum(), flag, kate);
			}
		}

		List<FileVO> fList = new ArrayList<FileVO>();
		List<ArrayList<FileVO>> fileList = new ArrayList<ArrayList<FileVO>>();
		MemberVO m = new MemberVO();
		List<MemberVO> mList = new ArrayList<MemberVO>();
		List<LikeImgVO> likeImgVO = null;
		List<ArrayList<LikeImgVO>> likeImgVOList = new ArrayList<ArrayList<LikeImgVO>>();

		if (list != null) {
			// 占쏙옙 占쏙옙호占쏙옙 占쌔댐옙占싹댐옙 占싱뱄옙占쏙옙 占쌨아울옙占쏙옙
			for (BoardVO vo : list) {
				fList = fileService.viewFile(vo.getBno());
				m = memberService.memberVO(vo.getWriter());
				likeImgVO = fileService.selectLikeImg(vo.getBno());
				fileList.add((ArrayList<FileVO>) fList);
				mList.add(m);
				likeImgVOList.add((ArrayList<LikeImgVO>) likeImgVO);
			}
			Gson gson = new Gson();
			String jsonList = gson.toJson(list);
			String jsonMList = gson.toJson(mList);
			String jsonFileList = gson.toJson(fileList);
			String jsonPage = gson.toJson(page);
			String jsonLikeImg = gson.toJson(likeImgVOList);

			HashMap<String, Object> data = new HashMap<String, Object>();
			data.put("board", jsonList);
			data.put("file", jsonFileList);
			data.put("member", jsonMList);
			data.put("page", jsonPage);
			data.put("likeImg", jsonLikeImg);

			return data;

		} else {

			HashMap<String, Object> data = new HashMap<String, Object>();

			return data;
		}

	}

	@ResponseBody
	@RequestMapping(value = "/getPageSearch", method = RequestMethod.POST)
	public HashMap<String, Object> getPageSearch(HttpServletRequest req, HttpSession session) throws Exception {
		int pageNum = Integer.parseInt(req.getParameter("pageNum"));
		String flag = req.getParameter("flag");
		String searchType = req.getParameter("searchType");
		String keyword = req.getParameter("keyword");
		MemberVO login = (MemberVO) session.getAttribute("session");
		String kate[] = req.getParameterValues("kate");
		System.out.println(kate);

		Page page = new Page();

		page.setNum(pageNum);
		page.setCount(service.count());

		List<BoardVO> list = null;

		if (searchType.equals("writer")) {
			MemberVO mVo = memberService.idCheck(keyword);
			if (mVo != null) {
				keyword = Integer.toString(mVo.getId());
			} else {
				keyword = "0";
			}
		}
		if (login != null) {
			List<FollowVO> fforfList = null;

			fforfList = memberService.fforfList(login.getId());
			if (fforfList.size() > 0) {
				list = service.getPageSearch(page.getDisplayPost(), page.getPostNum(), searchType, keyword, flag, kate,
						fforfList);
			} else {
				if (!flag.equals("fol")) {
					list = service.getPageSearch(page.getDisplayPost(), page.getPostNum(), searchType, keyword, flag, kate);
				}
			}
		} else {
			if (!flag.equals("fol")) {
				list = service.getPageSearch(page.getDisplayPost(), page.getPostNum(), searchType, keyword, flag, kate);
			}
		}

		List<FileVO> fList = new ArrayList<FileVO>();
		List<ArrayList<FileVO>> fileList = new ArrayList<ArrayList<FileVO>>();
		MemberVO m = new MemberVO();
		List<MemberVO> mList = new ArrayList<MemberVO>();
		List<LikeImgVO> likeImgVO = null;
		List<ArrayList<LikeImgVO>> likeImgVOList = new ArrayList<ArrayList<LikeImgVO>>();

		if (list != null) {
			// 占쏙옙 占쏙옙호占쏙옙 占쌔댐옙占싹댐옙 占싱뱄옙占쏙옙 占쌨아울옙占쏙옙
			for (BoardVO vo : list) {
				fList = fileService.viewFile(vo.getBno());
				m = memberService.memberVO(vo.getWriter());
				likeImgVO = fileService.selectLikeImg(vo.getBno());
				fileList.add((ArrayList<FileVO>) fList);
				mList.add(m);
				likeImgVOList.add((ArrayList<LikeImgVO>) likeImgVO);
			}
			Gson gson = new Gson();
			String jsonList = gson.toJson(list);
			String jsonMList = gson.toJson(mList);
			String jsonFileList = gson.toJson(fileList);
			String jsonPage = gson.toJson(page);
			String jsonLikeImg = gson.toJson(likeImgVOList);

			HashMap<String, Object> data = new HashMap<String, Object>();
			data.put("board", jsonList);
			data.put("file", jsonFileList);
			data.put("member", jsonMList);
			data.put("page", jsonPage);
			data.put("likeImg", jsonLikeImg);

			return data;

		} else {

			HashMap<String, Object> data = new HashMap<String, Object>();

			return data;
		}

	}

}