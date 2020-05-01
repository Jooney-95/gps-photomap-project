package com.board.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.board.domain.FileVO;
import com.board.domain.Files;

@Repository
public class FileDAOImpl implements FileDAO {

	@Inject
	private SqlSession sql;

	private static String namespace = "com.board.mappers.board";

	@Override
	public void write(List<MultipartFile> file) throws Exception {
		// TODO Auto-generated method stub

		Files files = new Files();
		
		sql.insert(namespace + ".writeFile", files.setFiles(file));
	}

	@Override
	public List<FileVO> viewFile(int bno) throws Exception {
		// TODO Auto-generated method stub
		
		return sql.selectList(namespace + ".viewFile");
	}

}
