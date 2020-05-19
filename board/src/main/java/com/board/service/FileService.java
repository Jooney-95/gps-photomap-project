package com.board.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.board.domain.FileVO;

public interface FileService {

	public void write(List<MultipartFile> file, int fileBno) throws Exception;

	public List<FileVO> viewFile(int bno) throws Exception;

	public void modifyFile(String[] str_id, String[] latitude, String[] longitude, String[] time) throws Exception;

	public void deleteFile(String[] delete) throws Exception;

}
