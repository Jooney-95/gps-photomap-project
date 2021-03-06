package com.board.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.board.domain.BoardVO;
import com.board.domain.FollowVO;
import com.board.domain.LikeVO;
import com.board.domain.SaveVO;
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

	@Override
	public LikeVO likeCheck(LikeVO vo) throws Exception {
		// TODO Auto-generated method stub
		return dao.likeCheck(vo);
	}

	@Override
	public void likeUp(LikeVO vo) throws Exception {
		// TODO Auto-generated method stub
		dao.likeUp(vo);
	}

	@Override
	public void likeDown(LikeVO vo) throws Exception {
		// TODO Auto-generated method stub
		dao.likeDown(vo);
	}

	@Override
	public int likeCnt(int tblBno) throws Exception {
		// TODO Auto-generated method stub
		return dao.likeCnt(tblBno);
	}

	@Override
	public void likeUpTbl(LikeVO vo) throws Exception {
		// TODO Auto-generated method stub
		dao.likeUpTbl(vo);
	}

	@Override
	public void likeDownTbl(LikeVO vo) throws Exception {
		// TODO Auto-generated method stub
		dao.likeDownTbl(vo);
	}

	@Override
	public int count(int userID) throws Exception {
		// TODO Auto-generated method stub
		return dao.count(userID);
	}

	@Override
	public List<BoardVO> getPage(int displayPost, int postNum, String flag) throws Exception {
		// TODO Auto-generated method stub
		return dao.getPage(displayPost, postNum, flag);
	}

	@Override
	public List<BoardVO> getPage(int displayPost, int postNum, String flag, List<FollowVO> fforfList) throws Exception {
		// TODO Auto-generated method stub
		return dao.getPage(displayPost, postNum, flag, fforfList);
	}
	
	@Override
	public List<BoardVO> getPage(int displayPost, int postNum, String flag, String kate[]) throws Exception {
		// TODO Auto-generated method stub
		return dao.getPage(displayPost, postNum, flag, kate);
	}

	@Override
	public List<BoardVO> getPage(int displayPost, int postNum, String flag, String kate[], List<FollowVO> fforfList) throws Exception {
		// TODO Auto-generated method stub
		return dao.getPage(displayPost, postNum, flag, kate, fforfList);
	}

	@Override
	public List<BoardVO> getPageSearch(int displayPost, int postNum, String searchType, String keyword, String flag, String[] kate)
			throws Exception {
		// TODO Auto-generated method stub
		return dao.getPageSearch(displayPost, postNum, searchType, keyword, flag, kate);
	}

	@Override
	public List<BoardVO> getPageSearch(int displayPost, int postNum, String searchType, String keyword, String flag, String[] kate,
			List<FollowVO> fforfList) throws Exception {
		// TODO Auto-generated method stub
		return dao.getPageSearch(displayPost, postNum, searchType, keyword, flag, kate, fforfList);
	}

	@Override
	public SaveVO saveCheck(SaveVO saveVO) throws Exception {
		// TODO Auto-generated method stub
		return dao.saveCheck(saveVO);
	}

	@Override
	public void savePage(SaveVO saveVO) throws Exception {
		// TODO Auto-generated method stub
		dao.savePage(saveVO);
		
	}

	@Override
	public void deletePage(SaveVO saveVO) throws Exception {
		// TODO Auto-generated method stub
		dao.deletePage(saveVO);
	}

	@Override
	public List<SaveVO> saveList(int userID) throws Exception {
		// TODO Auto-generated method stub
		return dao.saveList(userID);
	}

	@Override
	public List<BoardVO> savePageList(List<SaveVO> save, int displayPost, int postNum) throws Exception {
		// TODO Auto-generated method stub
		return dao.savePageList(save, displayPost, postNum);
	}

}
