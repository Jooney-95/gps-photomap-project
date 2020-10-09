package com.board.dao;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.board.domain.BoardVO;
import com.board.domain.FollowVO;
import com.board.domain.LikeVO;
import com.board.domain.SaveVO;

@Repository
public class BoardDAOImpl implements BoardDAO {

	@Inject
	private SqlSession sql;

	private static String namespace = "com.board.mappers.board";

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
	public List<BoardVO> listPageSearch(int displayPost, int postNum, String searchType, String keyword)
			throws Exception {

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

	@Override
	public List<BoardVO> MyPageSearch(int id, int displayPost, int postNum, String searchType, String keyword) {
		// TODO Auto-generated method stub

		HashMap<String, Object> data = new HashMap<String, Object>();

		data.put("writer", id);
		data.put("displayPost", displayPost);
		data.put("postNum", postNum);

		return sql.selectList(namespace + ".MyPageSearch", data);
	}

	@Override
	public LikeVO likeCheck(LikeVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sql.selectOne(namespace + ".likeCheck", vo);
	}

	@Override
	public void likeUp(LikeVO vo) throws Exception {
		// TODO Auto-generated method stub
		sql.insert(namespace + ".likeUp", vo);

	}

	@Override
	public void likeDown(LikeVO vo) throws Exception {
		// TODO Auto-generated method stub
		sql.delete(namespace + ".likeDown", vo);

	}

	@Override
	public int likeCnt(int tblBno) throws Exception {
		// TODO Auto-generated method stub
		return sql.selectOne(namespace + ".likeCnt", tblBno);
	}

	@Override
	public void likeUpTbl(LikeVO vo) throws Exception {
		// TODO Auto-generated method stub
		sql.update(namespace + ".likeUpTbl", vo);
	}

	@Override
	public void likeDownTbl(LikeVO vo) throws Exception {
		// TODO Auto-generated method stub
		sql.update(namespace + ".likeDownTbl", vo);
	}

	@Override
	public int count(int userID) throws Exception {
		// TODO Auto-generated method stub
		return sql.selectOne(namespace + ".countMyPage", userID);
	}

	@Override
	public List<BoardVO> getPage(int displayPost, int postNum, String flag) throws Exception {
		// TODO Auto-generated method stub
		HashMap<String, Object> data = new HashMap<String, Object>();

		data.put("displayPost", displayPost);
		data.put("postNum", postNum);
		data.put("flag", flag);
		if (flag.equals("like")) {
			return sql.selectList(namespace + ".getLikePage", data);
		} else {
			return sql.selectList(namespace + ".getNewPage", data);
		}
	}

	@Override
	public List<BoardVO> getPage(int displayPost, int postNum, String flag, List<FollowVO> fforfList) throws Exception {
		// TODO Auto-generated method stub

		HashMap<String, Object> data = new HashMap<String, Object>();

		data.put("displayPost", displayPost);
		data.put("postNum", postNum);
		data.put("flag", flag);
		data.put("fforfList", fforfList);
		if (flag.equals("like")) {
			return sql.selectList(namespace + ".getUserLikePage", data);
		} else if (flag.equals("new")) {
			return sql.selectList(namespace + ".getUserNewPage", data);
		} else {
			return sql.selectList(namespace + ".getUserFolPage", data);
		}
	}

	@Override
	public List<BoardVO> getPage(int displayPost, int postNum, String flag, String kate[]) throws Exception {
		// TODO Auto-generated method stub
		HashMap<String, Object> data = new HashMap<String, Object>();

		data.put("displayPost", displayPost);
		data.put("postNum", postNum);
		data.put("flag", flag);
		data.put("kate", kate[0]);
		if (flag.equals("like")) {
			return sql.selectList(namespace + ".getLikePage", data);
		} else {
			return sql.selectList(namespace + ".getNewPage", data);
		}
	}

	@Override
	public List<BoardVO> getPage(int displayPost, int postNum, String flag, String kate[], List<FollowVO> fforfList)
			throws Exception {
		// TODO Auto-generated method stub
		HashMap<String, Object> data = new HashMap<String, Object>();

		data.put("displayPost", displayPost);
		data.put("postNum", postNum);
		data.put("flag", flag);
		data.put("kate", kate[0]);
		data.put("fforfList", fforfList);
		if (flag.equals("like")) {
			return sql.selectList(namespace + ".getUserLikePage", data);
		} else if (flag.equals("new")) {
			return sql.selectList(namespace + ".getUserNewPage", data);
		} else {
			return sql.selectList(namespace + ".getUserFolPage", data);
		}
	}

	@Override
	public List<BoardVO> getPageSearch(int displayPost, int postNum, String searchType, String keyword, String flag, String[] kate)
			throws Exception {
		// TODO Auto-generated method stub
		HashMap<String, Object> data = new HashMap<String, Object>();

		data.put("displayPost", displayPost);
		data.put("postNum", postNum);
		data.put("flag", flag);
		data.put("searchType", searchType);
		data.put("keyword", keyword);
		data.put("kate", kate[0]);

		if (flag.equals("likeSearch")) {
			return sql.selectList(namespace + ".getLikeSearchPage", data);
		} else {
			return sql.selectList(namespace + ".getNewSearchPage", data);
		}
	}

	@Override
	public List<BoardVO> getPageSearch(int displayPost, int postNum, String searchType, String keyword, String flag, String[] kate,
			List<FollowVO> fforfList) throws Exception {
		// TODO Auto-generated method stub
		HashMap<String, Object> data = new HashMap<String, Object>();

		data.put("displayPost", displayPost);
		data.put("postNum", postNum);
		data.put("flag", flag);
		data.put("searchType", searchType);
		data.put("keyword", keyword);
		data.put("kate", kate[0]);
		data.put("fforfList", fforfList);

		if (flag.equals("likeSearch")) {
			return sql.selectList(namespace + ".getUserLikeSearchPage", data);
		} else if (flag.equals("newSearch")) {
			return sql.selectList(namespace + ".getUserNewSearchPage", data);
		} else {
			return sql.selectList(namespace + ".getUserFolSearchPage", data);
		}
	}

	@Override
	public SaveVO saveCheck(SaveVO saveVO) throws Exception {
		// TODO Auto-generated method stub
		return sql.selectOne(namespace + ".saveCheck", saveVO);
	}

	@Override
	public void savePage(SaveVO saveVO) throws Exception {
		// TODO Auto-generated method stub
		sql.insert(namespace + ".savePage", saveVO);
	}

	@Override
	public void deletePage(SaveVO saveVO) throws Exception {
		// TODO Auto-generated method stub
		sql.delete(namespace + ".deletePage", saveVO);
	}

	@Override
	public List<SaveVO> saveList(int userID) throws Exception {
		// TODO Auto-generated method stub
		return sql.selectList(namespace + ".saveList", userID);
	}

	@Override
	public List<BoardVO> savePageList(List<SaveVO> save, int displayPost, int postNum) throws Exception {
		// TODO Auto-generated method stub
		HashMap<String, Object> data = new HashMap<String, Object>();
		data.put("displayPost", displayPost);
		data.put("postNum", postNum);
		data.put("save", save);
		return sql.selectList(namespace + ".savePageList", data);
	}

}
