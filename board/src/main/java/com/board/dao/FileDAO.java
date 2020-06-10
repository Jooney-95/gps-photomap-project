package com.board.dao;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.board.domain.FileVO;

public interface FileDAO {

	public void write(List<MultipartFile> file, int fileBno, int userID) throws Exception;

	public List<FileVO> viewFile(int bno) throws Exception;

	public void modifyFile(String[] str_id, String[] latitude, String[] longitude, String[] time, String[] content) throws Exception;

	public void deleteFile(String[] delete) throws Exception;

	public void deleteFileBno(int bno) throws Exception;

	public void imgUpload(List<MultipartFile> file, int uesrID) throws Exception;

	public List<FileVO> imgSelect(int userID) throws Exception;

	public void writeClick(int fileBno, String[] id, String[] lat, String[] lon, String[] time, String[] content) throws Exception;

	public void beforeunload(int userID) throws Exception;

}
