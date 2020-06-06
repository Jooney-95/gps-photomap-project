package com.board.dao;

import java.util.List;

import com.board.domain.TpVO;

public interface TpDAO {

	void reset(String[] str_id) throws Exception;

	void set(TpVO tp)  throws Exception;

	List<TpVO> viewTp(int bno) throws Exception;

	void deleteFileBno(int bno) throws Exception;

}
