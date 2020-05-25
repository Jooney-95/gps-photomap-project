package com.board.dao;

import com.board.domain.MemberVO;

public interface MemberDAO {

	public void register(MemberVO vo) throws Exception;

	public MemberVO login(MemberVO vo) throws Exception;

}
