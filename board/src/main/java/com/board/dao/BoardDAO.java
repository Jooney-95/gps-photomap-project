package com.board.dao;

import java.util.List;

import com.board.domain.BoardVO;

public interface BoardDAO {
	
	// �Խù� ���
	public List<BoardVO> list() throws Exception;
	
	// �Խù� �ۼ�
	public int write(BoardVO vo) throws Exception;
	
	// �Խù� ��ȸ 
	public BoardVO view(int bno) throws Exception;
	
	// �Խù� ����
	public void modify(BoardVO vo) throws Exception;
	
	// �Խù� ����
	public void delete(int bno);
	
	// �Խù� �� ����
	public int count() throws Exception;

	// �Խù� ��� + ����¡
	public List<BoardVO> listPage(int displayPost, int postNum) throws Exception;

	public void hitViewCnt(int bno) throws Exception;
	
	// �Խù� ��� + ����¡ + �˻�
	public List<BoardVO> listPageSearch(
			int displayPost, int postNum, String searchType, String keyword) throws Exception;
}
