package com.board.dao;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.board.domain.FollowVO;
import com.board.domain.MemberVO;
import com.board.domain.Profile;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Inject
	private SqlSession sql;

	private static String namespace = "com.board.mappers.board";
	
	@Override
	public void register(MemberVO vo) throws Exception {
		// TODO Auto-generated method stub
		sql.insert(namespace + ".register", vo);
	}

	@Override
	public MemberVO login(MemberVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sql.selectOne(namespace + ".login", vo);
	}

	@Override
	public MemberVO idCheck(String mID) throws Exception {
		// TODO Auto-generated method stub
		return sql.selectOne(namespace + ".idCheck", mID);
	}

	@Override
	public MemberVO nicknameCheck(String mNickname) throws Exception {
		// TODO Auto-generated method stub
		return sql.selectOne(namespace + ".nicknameCheck", mNickname);
	}

	@Override
	public void profile(MemberVO vo, MultipartFile file) throws Exception {
		// TODO Auto-generated method stub
		Profile pro = new Profile();
		MemberVO mVO = sql.selectOne(namespace + ".memberVO", vo.getId());
		if(!(mVO.getmImg().equals("/resources/imgs/p1.png"))) {
			pro.deleteProfileImg(mVO.getmImg());
		}
		MemberVO mVo = pro.profileImg(vo, file);
		sql.update(namespace + ".profileImg", mVo);
	}

	@Override
	public void profile(MemberVO vo) throws Exception {
		// TODO Auto-generated method stub
		sql.update(namespace + ".profile", vo);
	}

	@Override
	public MemberVO pwCheck(String mID) throws Exception {
		// TODO Auto-generated method stub
		return sql.selectOne(namespace + ".pwCheck", mID);
	}

	@Override
	public void password(MemberVO vo) throws Exception {
		// TODO Auto-generated method stub
		sql.update(namespace + ".password", vo);
	}
	
	@Override
	public MemberVO memberVO(int id) throws Exception {
		// TODO Auto-generated method stub
		return sql.selectOne(namespace + ".memberVO", id);
	}

	@Override
	public FollowVO followingCheck(FollowVO fVo) throws Exception {
		// TODO Auto-generated method stub
		return sql.selectOne(namespace + ".followingCheck", fVo);
	}

	@Override
	public void follow(FollowVO fVo) throws Exception {
		// TODO Auto-generated method stub
		sql.insert(namespace + ".follow", fVo);
	}

	@Override
	public void unFollow(FollowVO fVo) throws Exception {
		// TODO Auto-generated method stub
		sql.delete(namespace + ".unFollow", fVo);
	}

	@Override
	public void fforf(FollowVO fVo) throws Exception {
		// TODO Auto-generated method stub
		sql.update(namespace + ".fforf", fVo);
	}

	@Override
	public void unFforf(FollowVO fVo) throws Exception {
		// TODO Auto-generated method stub
		sql.update(namespace + ".unFforf", fVo);
	}

	@Override
	public List<FollowVO> userFollow(int userID) throws Exception {
		// TODO Auto-generated method stub
		return sql.selectList(namespace + ".userFollow", userID);
	}

	@Override
	public List<FollowVO> userFollowing(int userID) throws Exception {
		// TODO Auto-generated method stub
		return sql.selectList(namespace + ".userFollowing", userID);
	}

	@Override
	public List<MemberVO> followMemberVO(List<FollowVO> follow) throws Exception {
		// TODO Auto-generated method stub
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("list", follow);
		return sql.selectList(namespace + ".followMemberVO", map);
	}

	@Override
	public List<FollowVO> fforfList(int id) throws Exception {
		// TODO Auto-generated method stub
		return sql.selectList(namespace + ".fforfList", id);
	}

}
