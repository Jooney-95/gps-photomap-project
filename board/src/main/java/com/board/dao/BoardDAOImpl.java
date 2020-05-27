package com.board.dao;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.board.domain.BoardVO;


@Repository
public class BoardDAOImpl implements BoardDAO {
	
	@Inject
	private SqlSession sql;
	
	private static String namespace = "com.board.mappers.board";

	@Override
	public List<BoardVO> list() throws Exception {
		// TODO Auto-generated method stub
		return sql.selectList(namespace + ".list");
	}

	@Override
	public int write(BoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		sql.insert(namespace + ".write", vo);
		return vo.getBno();
	}

	@Override
	public BoardVO view(int bno) throws Exception {
		// TODO Auto-generated method stub
		return sql.selectOne(namespace + ".view", bno);
	}

	@Override
	public void modify(BoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		sql.update(namespace + ".modify", vo);
	}

	@Override
	public void delete(int bno) {
		// TODO Auto-generated method stub
		sql.delete(namespace + ".delete", bno);
	}

	@Override
	public int count() throws Exception {
		// TODO Auto-generated method stub
		return sql.selectOne(namespace + ".count");
	}

	
	// 게시물 목록 + 페이징 + 검색
	@Override
	public List<BoardVO> listPageSearch(
			int displayPost, int postNum, String searchType, String keyword) throws Exception {

		HashMap<String, Object> data = new HashMap<String, Object>();
	  
		data.put("displayPost", displayPost);
		data.put("postNum", postNum);
	  
		data.put("searchType", searchType);
		data.put("keyword", keyword);
	  
		return sql.selectList(namespace + ".listPageSearch", data);
	 }
	 
	@Override
	public void hitViewCnt(int bno) throws Exception {
		// TODO Auto-generated method stub
		sql.update(namespace + ".hitViewCnt", bno);
	}

}
