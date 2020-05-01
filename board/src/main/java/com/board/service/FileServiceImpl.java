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
	public void write(List<MultipartFile> file) throws Exception {
		// TODO Auto-generated method stub
		dao.write(file);
	}

	@Override
	public List<FileVO> viewFile(int bno) throws Exception {
		// TODO Auto-generated method stub
		return dao.viewFile(bno);
	}

}
