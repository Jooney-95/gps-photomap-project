package com.board.domain;

import java.io.File;

import org.springframework.web.multipart.MultipartFile;

public class Profile {
	
	private static final String PREFIX_URL = "/img/";
	
	UploadFiles f = new UploadFiles();
	
	public MemberVO profileImg(MemberVO vo, MultipartFile file) throws Exception {
		// TODO Auto-generated method stub
		
		String[] saveFileName = f.getRandomString();
		f.fileWrite(file, saveFileName[0]);
		File convFile = new File(saveFileName[0]);
		file.transferTo(convFile);
		
		vo.setmImg(PREFIX_URL + saveFileName[0]);
		
		return vo;
	}
}
