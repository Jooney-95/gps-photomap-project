package com.board.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.board.domain.BoardVO;
import com.board.domain.FileVO;
import com.board.domain.Page;
import com.board.service.BoardService;
import com.board.service.FileService;


@Controller
@RequestMapping("/board/*")
public class BoardController {

	@Inject
	BoardService service;
	
	@Inject
	FileService fileService;
	
	
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public void getList(Model model) throws Exception {
		
		List<BoardVO> list = null;
		list = service.list();
		
		model.addAttribute("list", list);
	}
	
	@RequestMapping(value="/write", method=RequestMethod.GET)
	public void getWrite() throws Exception{
		
	}
	
	@RequestMapping(value="/write", method=RequestMethod.POST)
	public String postWriter(BoardVO vo, MultipartHttpServletRequest request) throws Exception{
		int fileBno = service.write(vo);
		
		List<MultipartFile> file = request.getFiles("filesList");
		System.out.println();
		if(file.get(0).getSize() != 0) {
			fileService.write(file, fileBno);
		}
		
		return "redirect:/board/listPageSearch?num=1";
	}
	
	@RequestMapping(value="/view", method=RequestMethod.GET)
	public void getView(@RequestParam("bno") int bno, Model model) throws Exception{
		
		BoardVO vo = service.view(bno);
		service.hitViewCnt(bno);
		List<FileVO> list = null;
		list = fileService.viewFile(bno);
		
		model.addAttribute("view", vo);
		model.addAttribute("list", list);

		
		
	}
	
	@RequestMapping(value="/modify", method=RequestMethod.GET)
	public void getModify(@RequestParam("bno") int bno, Model model) throws Exception{
		BoardVO vo = service.view(bno);
		
		List<FileVO> list = null;
		list = fileService.viewFile(bno);
		
		model.addAttribute("view", vo);
		model.addAttribute("list", list);
	}
	
	@RequestMapping(value="/modify", method=RequestMethod.POST)
	public String postModify(MultipartHttpServletRequest request, HttpServletRequest req, BoardVO vo) throws Exception{
		service.modify(vo);
		
		String fileBno = req.getParameter("bno");
		String[] str_id = req.getParameterValues("id");
		String[] time = req.getParameterValues("time");
		String[] delete = req.getParameterValues("del");
		String[] latitude = req.getParameterValues("lat");
		String[] longitude = req.getParameterValues("lon");
		
		if(str_id != null) {
			fileService.modifyFile(str_id, latitude, longitude, time);
		}
		if(delete != null) {
			fileService.deleteFile(delete);
		}
		
		List<MultipartFile> file = request.getFiles("filesList");
		if(file.get(0).getSize() != 0) {
			fileService.write(file, Integer.parseInt(fileBno));
			}
		
		return "redirect:/board/view?bno=" + vo.getBno();
	}
	
	@RequestMapping(value="/delete", method=RequestMethod.GET)
	public String getDelete(@RequestParam("bno") int bno) throws Exception{
		service.delete(bno);
		
		return "redirect:/board/listPageSearch?num=1";
	}

	
	// 게시물 목록 + 페이징 추가 + 검색
	@RequestMapping(value = "/listPageSearch", method = RequestMethod.GET)
	public void getListPageSearch(Model model, @RequestParam("num") int num, 
			@RequestParam(value = "searchType",required = false, defaultValue = "title") String searchType,
			@RequestParam(value = "keyword",required = false, defaultValue = "") String keyword
			) throws Exception {

	 
		Page page = new Page();
	 
		page.setNum(num);
		page.setCount(service.count());  
	 
		List<BoardVO> list = null; 
		//list = service.listPage(page.getDisplayPost(), page.getPostNum());
		list = service.listPageSearch(page.getDisplayPost(), page.getPostNum(), searchType, keyword);
	 
		model.addAttribute("list", list);
		model.addAttribute("page", page);
		model.addAttribute("select", num);
	 
	}
}