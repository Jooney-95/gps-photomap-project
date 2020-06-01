package com.board.service;

import java.util.List;

import com.board.domain.TpVO;

public interface TpService {

	void reset(String[] str_id) throws Exception;

	void set(TpVO tp) throws Exception;

	public List<TpVO> viewTp(int bno) throws Exception;
	
}
