package com.board.domain;

import java.io.File;

import org.springframework.web.multipart.MultipartFile;

public class Profile {
	
	private static final String PREFIX_URL = "/img/";
	
	Files f = new Files();
	
	public MemberVO profileImg(MemberVO vo, MultipartFile file) throws Exception {
		// TODO Auto-generated method stub
		
		String saveFileName = f.getRandomString();
		f.fileWrite(file, saveFileName);
		File convFile = new File(saveFileName);
		file.transferTo(convFile);
		
		vo.setmImg(PREFIX_URL + saveFileName);
		
		return vo;
	}
}
