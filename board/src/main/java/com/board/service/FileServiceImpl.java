package com.board.service;

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
	public void write(List<MultipartFile> file, int fileBno) throws Exception {
		// TODO Auto-generated method stub
		dao.write(file, fileBno);
	}

	@Override
	public List<FileVO> viewFile(int bno) throws Exception {
		// TODO Auto-generated method stub
		return dao.viewFile(bno);
	}

	@Override
	public void modifyFile(String[] str_id, String[] latitude, String[] longitude, String[] time) throws Exception {
		// TODO Auto-generated method stub
		dao.modifyFile(str_id, latitude, longitude, time);
	}

	@Override
	public void deleteFile(String[] delete) throws Exception {
		// TODO Auto-generated method stub
		dao.deleteFile(delete);
	}

}
