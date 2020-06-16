package com.board.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.board.domain.FollowVO;
import com.board.domain.MemberVO;

public interface MemberService {

	public void register(MemberVO vo) throws Exception;

	public MemberVO login(MemberVO vo) throws Exception;
	
	public MemberVO idCheck(String mID) throws Exception;

	public MemberVO nicknameCheck(String mNickname) throws Exception;

	public void profile(MemberVO vo, MultipartFile file) throws Exception;

	public void profile(MemberVO vo) throws Exception;

	public MemberVO pwCheck(String mID) throws Exception;

	public void password(MemberVO vo) throws Exception;

	public MemberVO memberVO(int id) throws Exception;

	public FollowVO followingCheck(FollowVO fVo) throws Exception;

	public void follow(FollowVO fVo) throws Exception;

	public void unFollow(FollowVO fVo) throws Exception;

	public void fforf(FollowVO fVo) throws Exception;

	public void unFforf(FollowVO fVo) throws Exception;

	public List<FollowVO> userFollow(int userID) throws Exception;

	public List<FollowVO> userFollowing(int userID) throws Exception;

	public List<MemberVO> followMemberVO(List<FollowVO> follow) throws Exception;

	
}
