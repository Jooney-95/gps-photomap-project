package com.board.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.board.domain.BoardVO;
import com.board.dao.BoardDAO;

@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardDAO dao;

	@Override
	public int write(BoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		return dao.write(vo);
	}

	@Override
	public BoardVO view(int bno) throws Exception {
		// TODO Auto-generated method stub
		return dao.view(bno);
	}

	@Override
	public void modify(BoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		dao.modify(vo);
	}

	@Override
	public void delete(int bno) throws Exception {
		// TODO Auto-generated method stub
		dao.delete(bno);
	}

	@Override
	public int count() throws Exception {
		// TODO Auto-generated method stub
		return dao.count();
	}

	// 게시물 목록 + 페이징 + 검색
	@Override
	public List<BoardVO> listPageSearch(int displayPost, int postNum, String searchType, String keyword)
			throws Exception {
		return dao.listPageSearch(displayPost, postNum, searchType, keyword);
	}

	@Override
	public void hitViewCnt(int bno) throws Exception {
		// TODO Auto-generated method stub
		dao.hitViewCnt(bno);
	}

	@Override
	public List<BoardVO> MyPageSearch(int id, int displayPost, int postNum, String searchType, String keyword)
			throws Exception {
		// TODO Auto-generated method stub
		return dao.MyPageSearch(id, displayPost, postNum, searchType, keyword);
	}

}
