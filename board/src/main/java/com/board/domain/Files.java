package com.board.domain;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.drew.imaging.ImageMetadataReader;
import com.drew.metadata.Metadata;

import java.util.Iterator;
import com.drew.metadata.Tag;
import com.drew.metadata.Directory;
import com.drew.imaging.jpeg.JpegMetadataReader;
import com.drew.imaging.jpeg.JpegProcessingException;

public class Files {

	private static final String SAVE_PATH = "C:\\Users\\skyhu\\Desktop\\fileUpload";
	private static final String PREFIX_URL = "/upload/";

	private List<MultipartFile> files = null;

	private List<String> filesGPS = null;
	private List<String> filesTime = null;

	public void setFiles(List<MultipartFile> filesList) throws Exception {
		this.files = filesList;
		getFilesData(files);
	}

	private void getFilesData(List<MultipartFile> files) throws Exception {
    	for(MultipartFile getFile : files) {
    		
    		restore(getFile, getFile.getOriginalFilename());
    		
    		
    		try {
                
                File jpegFile = new File("C:\\\\Users\\\\skyhu\\\\Desktop\\\\fileUpload\\dkdldb123.JPG");
                Metadata metadata = JpegMetadataReader.readMetadata(jpegFile);
                
                for (Directory directory : metadata.getDirectories()) {
                    for (Tag tag : directory.getTags()){
                    	if(tag.getTagName().equals("User Comment"))continue;
                        System.out.print("[");
                        System.out.print(tag.getDirectoryName());
                        System.out.print("]");
                        System.out.print(tag.getTagName());
                        System.out.print(" - ");
                        System.out.println(tag.getDescription());
                    }
                    for (String error : directory.getErrors()){
                        System.err.println("ERROR: " + error);
                    }
                }
                } catch(IOException ex) {
                
                }
    		 

 
    		
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
