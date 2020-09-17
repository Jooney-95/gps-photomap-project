package com.board.dao;

import java.util.List;

import com.board.domain.BoardVO;
import com.board.domain.FollowVO;
import com.board.domain.LikeVO;

public interface BoardDAO {

	public int write(BoardVO vo) throws Exception;

	public BoardVO view(int bno) throws Exception;

	public void modify(BoardVO vo) throws Exception;

	public void delete(int bno);

	public int count() throws Exception;

	// 게시물 목록 + 페이징 + 검색
	public List<BoardVO> listPageSearch(int displayPost, int postNum, String searchType, String keyword)
			throws Exception;

	public void hitViewCnt(int bno) throws Exception;

	public List<BoardVO> MyPageSearch(int id, int displayPost, int postNum, String searchType, String keyword) throws Exception;

	public LikeVO likeCheck(LikeVO vo) throws Exception;

	public void likeUp(LikeVO vo) throws Exception;

	public void likeDown(LikeVO vo) throws Exception;

	public int likeCnt(int tblBno) throws Exception;

	public void likeUpTbl(LikeVO vo) throws Exception;
	
	public void likeDownTbl(LikeVO vo) throws Exception;

	public int count(int userID) throws Exception;

	public List<BoardVO> getPage(int displayPost, int postNum, String flag) throws Exception;

	public List<BoardVO> getPage(int displayPost, int postNum, String flag, List<FollowVO> fforfList) throws Exception;
	
	public List<BoardVO> getPage(int displayPost, int postNum, String flag, String[] kate) throws Exception;

	public List<BoardVO> getPage(int displayPost, int postNum, String flag, String[] kate, List<FollowVO> fforfList) throws Exception;

	public List<BoardVO> getPageSearch(int displayPost, int postNum, String searchType, String keyword, String flag, String[] kate) throws Exception;
	
	public List<BoardVO> getPageSearch(int displayPost, int postNum, String searchType, String keyword, String flag,
			String[] kate, List<FollowVO> fforfList) throws Exception;

}
