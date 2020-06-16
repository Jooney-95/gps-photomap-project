package com.board.service;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.board.dao.FileDAO;
import com.board.domain.FileVO;

@Service
public class FileServiceImpl implements FileService {

	@Inject
	private FileDAO dao;
	
	@Override
	public List<FileVO> viewFile(int bno) throws Exception {
		// TODO Auto-generated method stub
		return dao.viewFile(bno);
	}
	
	@Override
	public void deleteFile(String[] delete) throws Exception {
		// TODO Auto-generated method stub
		dao.deleteFile(delete);
	}

	@Override
	public void deleteFileBno(int bno) throws Exception {
		// TODO Auto-generated method stub
		dao.deleteFileBno(bno);
	}

	@Override
	public void imgUpload(List<MultipartFile> file, int uesrID) throws Exception {
		// TODO Auto-generated method stub
		dao.imgUpload(file, uesrID);
	}

	@Override
	public List<FileVO> imgSelect(int userID) throws Exception {
		// TODO Auto-generated method stub
		return dao.imgSelect(userID);
	}

	@Override
	public void beforeunload(int userID) throws Exception {
		// TODO Auto-generated method stub
		dao.beforeunload(userID);
	}

	@Override
	public void writeClick(HashMap<String, Object> fileMap) throws Exception {
		// TODO Auto-generated method stub
		dao.writeClick(fileMap);
	}

}
