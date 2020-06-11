package com.board.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.board.domain.TpVO;

@Repository
public class TpDAOImpl implements TpDAO {

	@Inject
	private SqlSession sql;

	private static String namespace = "com.board.mappers.board";
	
	@Override
	public void reset(String[] str_id) throws Exception {
		// TODO Auto-generated method stub
		int id;
		for(int i = 0; i < str_id.length; i++) {
			id = Integer.parseInt(str_id[i]);
			sql.delete(namespace + ".reset", id);
		}
	}

	@Override
	public void set(TpVO tp) throws Exception {
		// TODO Auto-generated method stub
		sql.insert(namespace + ".set", tp);
	}

	@Override
	public List<TpVO> viewTp(int bno) throws Exception {
		// TODO Auto-generated method stub
		return sql.selectList(namespace + ".viewTp", bno);
	}

	@Override
	public void deleteFileBno(int bno) throws Exception {
		// TODO Auto-generated method stub
		sql.delete(namespace + ".deleteTFB", bno);
	}

}
