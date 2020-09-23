package com.board.domain;

import java.io.File;
import java.util.Calendar;

import org.springframework.web.multipart.MultipartFile;

public class Profile {
	
	private static final String SAVE_PATH = "C:/var/Plus/upload/profile/";
	private static final String PREFIX_URL = "/img/profile/thumb/";
	
	UploadFiles f = new UploadFiles();
	
	public MemberVO profileImg(MemberVO vo, MultipartFile file) throws Exception {
		// TODO Auto-generated method stub
		
		Calendar cal = Calendar.getInstance();
		File dir = new File(SAVE_PATH + String.format("%04d/%02d/%02d/", cal.get(Calendar.YEAR), cal.get(Calendar.MONTH) + 1,
				cal.get(Calendar.DAY_OF_MONTH)));
		dir.mkdirs();
		dir = new File(SAVE_PATH + "thumb/" + String.format("%04d/%02d/%02d/", cal.get(Calendar.YEAR), cal.get(Calendar.MONTH) + 1,
				cal.get(Calendar.DAY_OF_MONTH)));
		dir.mkdirs();
		
		
		String[] saveFileName = f.getRandomString();
		f.fileWrite(file, "profile/" + saveFileName[0]);
		File convFile = new File(SAVE_PATH + saveFileName[0]);
		file.transferTo(convFile);
		f.makeThumbnail(saveFileName, "profile");
		
		vo.setmImg(PREFIX_URL + saveFileName[0]);
		
		return vo;
	}
	
	public void deleteProfileImg(String path) {
		String profileImgPath = "C:/var/Plus/upload/profile" + path.substring(18, path.length());
		String profileThumbPath = "C:/var/Plus/upload"+ path.substring(4, path.length());
		
		File[] file = new File[2];
		file[0] = new File(profileImgPath);
		file[1] = new File(profileThumbPath);
		
		for(File f : file) {
			if (f.exists()) {
				f.delete();
				System.out.println("프로필 존재 : " + f.exists() + " 삭제 경로 : " + f.getPath());
			}
		}
		
	}
	
}
