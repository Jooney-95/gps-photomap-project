package com.board.domain;

import java.io.FileOutputStream;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

public class Files {
	
	private static final Logger log = LoggerFactory.getLogger(Files.class);

    private static final String SAVE_PATH = "C:\\Users\\skyhu\\Desktop\\fileUpload";
    private static final String PREFIX_URL = "/upload/";
    
    
    private List<MultipartFile> files = null;

    private List<String> filesGPS = null;
    private List<String> filesTime = null;

    public void setFiles(List<MultipartFile> filesList) throws Exception {
        this.files = filesList;

        this.getFilesData(files);
    }

    private void getFilesData(List<MultipartFile> files) throws Exception {
    	for(MultipartFile getFile : files) {
    		
    		log.info(getFile.getOriginalFilename());
    		restore(getFile, getFile.getOriginalFilename());
    	}
    }

    public void restore(MultipartFile multipartFile, String fileName) throws Exception {
        writeFile(multipartFile, fileName);
    }

    private boolean writeFile(MultipartFile multipartFile, String saveFileName) throws Exception {
    	boolean result = false;

		byte[] data = multipartFile.getBytes();
		FileOutputStream fos = new FileOutputStream(SAVE_PATH + "/" + saveFileName);
		fos.write(data);
		fos.close();
		
		return result;
    }
}
