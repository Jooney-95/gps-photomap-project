package com.board.domain;

import java.io.File;
import java.util.Calendar;

import org.springframework.web.multipart.MultipartFile;

public class Profile {

	private static final String SAVE_PATH = "C:/var/Plus/upload/";

	UploadFiles f = new UploadFiles();

	public MemberVO profileImg(MemberVO vo, MultipartFile file) throws Exception {
		// TODO Auto-generated method stub

		File dir = new File(SAVE_PATH + f.PATH + "profile/");
		dir.mkdirs();

		String saveFileName = f.getRandomString();
		f.fileWrite(file, "profile/" + saveFileName);
		File convFile = new File(SAVE_PATH + f.PATH + saveFileName);
		file.transferTo(convFile);
		f.makeThumbnail("profile/" + saveFileName, "profile");

		vo.setmImg("/img/" + f.PATH + "profile/" + saveFileName);

		return vo;
	}

	public void deleteProfileImg(String path) {
		String profileImgPath = "C:/var/Plus/upload/" + path.substring(4, path.length());

		File file = new File(profileImgPath);

		if (file.exists()) {
			file.delete();
		}
	}
}
