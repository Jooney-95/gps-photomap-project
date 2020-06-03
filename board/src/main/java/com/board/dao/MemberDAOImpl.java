package com.board.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

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

}
