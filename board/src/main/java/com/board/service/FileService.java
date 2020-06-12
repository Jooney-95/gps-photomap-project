package com.board.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.board.domain.FileVO;

public interface FileService {

	public List<FileVO> viewFile(int bno) throws Exception;

	public void deleteFile(String[] delete) throws Exception;

	public void deleteFileBno(int bno) throws Exception;

	public void imgUpload(List<MultipartFile> file, int uesrID) throws Exception;

	public List<FileVO> imgSelect(int userID) throws Exception;

	public void beforeunload(int userID) throws Exception;

	public void writeClick(HashMap<String, Object> fileMap) throws Exception;

}
