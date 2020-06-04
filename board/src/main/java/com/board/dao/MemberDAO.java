package com.board.dao;

import org.springframework.web.multipart.MultipartFile;

import com.board.domain.MemberVO;

public interface MemberDAO {

	public void register(MemberVO vo) throws Exception;

	public MemberVO login(MemberVO vo) throws Exception;

	public MemberVO idCheck(String mID) throws Exception;

	public MemberVO nicknameCheck(String mNickname) throws Exception;

	public void profile(MemberVO vo, MultipartFile file) throws Exception;

	public void profile(MemberVO vo) throws Exception;

	public MemberVO pwCheck(String mID) throws Exception;

	public void password(MemberVO vo) throws Exception;

	public int countMyPage(int id) throws Exception;

	public MemberVO memberVO(int id) throws Exception;

}
