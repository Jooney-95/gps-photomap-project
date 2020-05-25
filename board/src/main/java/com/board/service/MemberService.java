package com.board.service;

import com.board.domain.MemberVO;

public interface MemberService {

	public void register(MemberVO vo) throws Exception;

	public MemberVO login(MemberVO vo) throws Exception;
	
}
