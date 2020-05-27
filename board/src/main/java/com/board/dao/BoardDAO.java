package com.board.dao;

import java.util.List;

import com.board.domain.BoardVO;

public interface BoardDAO {

	public List<BoardVO> list() throws Exception;
	
	public int write(BoardVO vo) throws Exception;
	
	public BoardVO view(int bno) throws Exception;

	public void modify(BoardVO vo) throws Exception;

	public void delete(int bno);

	public int count() throws Exception;
	
	// �Խù� ��� + ����¡ + �˻�
	public List<BoardVO> listPageSearch(
			int displayPost, int postNum, String searchType, String keyword) throws Exception;

	public void hitViewCnt(int bno) throws Exception;
}
