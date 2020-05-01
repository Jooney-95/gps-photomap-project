package com.board.dao;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.board.domain.FileVO;

public interface FileDAO {

	public void write(List<MultipartFile> file) throws Exception;

	public List<FileVO> viewFile(int bno) throws Exception;

}
