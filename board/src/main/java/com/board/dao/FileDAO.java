package com.board.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.board.domain.FileVO;
import com.board.domain.LikeImgVO;

public interface FileDAO {

	public List<FileVO> viewFile(int bno) throws Exception;

	public void modifyFile(String[] str_id, String[] latitude, String[] longitude, String[] time, String[] content) throws Exception;

	public void deleteFile(String[] delete) throws Exception;

	public void deleteFileBno(int bno) throws Exception;

	public void imgUpload(List<MultipartFile> file, int uesrID) throws Exception;

	public List<FileVO> writeFile(int userID) throws Exception;
	
	public List<FileVO> modifyFile(int userID, int bno) throws Exception;

	public void beforeunload(int userID) throws Exception;

	public void writeClick(HashMap<String, Object> fileMap) throws Exception;

	public void likeImgs(HashMap<String, Object> likeImgMap) throws Exception;

	public void deleteLikeImgs(int fileBno) throws Exception;

	public List<LikeImgVO> selectLikeImg(int fileBno) throws Exception;


}
