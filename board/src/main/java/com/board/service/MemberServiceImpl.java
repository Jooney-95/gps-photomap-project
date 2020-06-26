package com.board.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;


import com.board.dao.MemberDAO;
import com.board.domain.FollowVO;
import com.board.domain.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	private MemberDAO dao;
	
	@Override
	public void register(MemberVO vo) throws Exception {
		// TODO Auto-generated method stub
		dao.register(vo);
	}

	@Override
	public MemberVO login(MemberVO vo) throws Exception {
		// TODO Auto-generated method stub
		return dao.login(vo);
	}

	@Override
	public MemberVO idCheck(String mID) throws Exception {
		// TODO Auto-generated method stub
		return dao.idCheck(mID);
	}

	@Override
	public MemberVO nicknameCheck(String mNickname) throws Exception {
		// TODO Auto-generated method stub
		return dao.nicknameCheck(mNickname);
	}

	@Override
	public void profile(MemberVO vo, MultipartFile file) throws Exception {
		// TODO Auto-generated method stub
		dao.profile(vo, file);
	}

	@Override
	public void profile(MemberVO vo) throws Exception {
		// TODO Auto-generated method stub
		dao.profile(vo);
	}

	@Override
	public MemberVO pwCheck(String mID) throws Exception {
		// TODO Auto-generated method stub
		return dao.pwCheck(mID);
	}

	@Override
	public void password(MemberVO vo) throws Exception {
		// TODO Auto-generated method stub
		dao.password(vo);
	}

	@Override
	public MemberVO memberVO(int id) throws Exception {
		// TODO Auto-generated method stub
		return dao.memberVO(id);
	}

	@Override
	public FollowVO followingCheck(FollowVO fVo) throws Exception {
		// TODO Auto-generated method stub
		return dao.followingCheck(fVo);
	}

	@Override
	public void follow(FollowVO fVo) throws Exception {
		// TODO Auto-generated method stub
		dao.follow(fVo);
	}

	@Override
	public void unFollow(FollowVO fVo) throws Exception {
		// TODO Auto-generated method stub
		dao.unFollow(fVo);
	}

	@Override
	public void fforf(FollowVO fVo) throws Exception {
		// TODO Auto-generated method stub
		dao.fforf(fVo);
	}

	@Override
	public void unFforf(FollowVO fVo) throws Exception {
		// TODO Auto-generated method stub
		dao.unFforf(fVo);
	}

	@Override
	public List<FollowVO> userFollow(int userID) throws Exception {
		// TODO Auto-generated method stub
		return dao.userFollow(userID);
	}

	@Override
	public List<FollowVO> userFollowing(int userID) throws Exception {
		// TODO Auto-generated method stub
		return dao.userFollowing(userID);
	}

	@Override
	public List<MemberVO> followMemberVO(List<FollowVO> follow) throws Exception {
		// TODO Auto-generated method stub
		return dao.followMemberVO(follow);
	}

	@Override
	public List<FollowVO> fforfList(int id) throws Exception {
		// TODO Auto-generated method stub
		return dao.fforfList(id);
	}


}
