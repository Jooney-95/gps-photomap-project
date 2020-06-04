package com.board.service;

import java.util.List;

import com.board.domain.BoardVO;

public interface BoardService {

	public int write(BoardVO vo) throws Exception;

	public BoardVO view(int bno) throws Exception;

	public void modify(BoardVO vo) throws Exception;

	public void delete(int bno) throws Exception;

	public int count() throws Exception;

	// 게시물 목록 + 페이징 + 검색
	public List<BoardVO> listPageSearch(int displayPost, int postNum, String searchType, String keyword) throws Exception;

	public void hitViewCnt(int bno) throws Exception;

	public List<BoardVO> MyPageSearch(int id, int displayPost, int postNum, String searchType, String keyword) throws Exception;
}
