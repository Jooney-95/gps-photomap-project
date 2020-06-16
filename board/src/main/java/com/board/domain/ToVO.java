package com.board.domain;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class ToVO {

	public LikeVO likeVO(int tblBno, int userID) {
		
		LikeVO vo = new LikeVO();
		vo.setTblBno(tblBno);
		vo.setUserID(userID);
		
		return vo;
	}
	
	public BoardVO boardVO(String title, int userID, int pNum) {
		BoardVO vo = new BoardVO();

		vo.setTitle(title);
		vo.setWriter(userID);
		vo.setpNum(pNum);
		
		return vo;
	}
	
	public BoardVO boardVO(String title, int userID, int pNum, int bno) {
		BoardVO vo = new BoardVO();

		vo.setTitle(title);
		vo.setWriter(userID);
		vo.setpNum(pNum);
		vo.setBno(bno);
		
		return vo;
	}
	
	public TpVO tpVO(String id, String tp, int fileBno) {
		TpVO vo = new TpVO();
		vo.setTpBno(Integer.parseInt(id));
		vo.setTp(tp);
		vo.setFileBno(fileBno);
		
		return vo;
	}
	
	public HashMap<String, Object> writeClick(int fileBno, String[] id, String[] lat, String[] lon, String[] time, String[] content, int size) {
		// TODO Auto-generated method stub
		List<FileVO> fileVOList = new ArrayList<FileVO>();
		FileVO[] fileVO = new FileVO[size];
		
		for (int i = 0; i < size; i++) {
			if(id[i] != "") {
				fileVO[i] = new FileVO();
				fileVO[i].setFileBno(fileBno);
				fileVO[i].setId(Integer.parseInt(id[i]));
				fileVO[i].setLatitude(lat[i].trim());
				fileVO[i].setLongitude(lon[i].trim());
				fileVO[i].setTimeView(time[i].trim());
				fileVO[i].setContent(content[i]);
				fileVOList.add(fileVO[i]);
			}
		}
		
		HashMap<String, Object> fileMap = new HashMap<String, Object>();
		fileMap.put("fileVOList", fileVOList);

		return fileMap;
	}
	

	
}
