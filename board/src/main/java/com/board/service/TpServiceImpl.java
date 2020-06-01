package com.board.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.board.dao.TpDAO;
import com.board.domain.TpVO;

@Service
public class TpServiceImpl implements TpService {

	@Inject
	private TpDAO dao;
	
	@Override
	public void reset(String[] str_id) throws Exception {
		// TODO Auto-generated method stub
		dao.reset(str_id);
	}

	@Override
	public void set(TpVO tp) throws Exception {
		// TODO Auto-generated method stub
		dao.set(tp);
	}

	@Override
	public List<TpVO> viewTp(int bno) throws Exception {
		// TODO Auto-generated method stub
		return dao.viewTp(bno);
	}

}
