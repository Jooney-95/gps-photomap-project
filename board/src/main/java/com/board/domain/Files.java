package com.board.domain;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.drew.imaging.jpeg.JpegMetadataReader;
import com.drew.imaging.jpeg.JpegProcessingException;
import com.drew.lang.GeoLocation;
import com.drew.metadata.Metadata;
import com.drew.metadata.exif.ExifSubIFDDirectory;
import com.drew.metadata.exif.GpsDirectory;

public class Files {

	private static final String SAVE_PATH = "C:\\Users\\skyhu\\Desktop\\fileUpload";
	private static final String PREFIX_URL = "/upload/";

	private List<MultipartFile> files = null;

	private String GPS[];
	private String TIME[];
	private String location;
	private int SIZE = 0;
	private int i = 0;

	public List<FileVO> fileVOList = new ArrayList<FileVO>();

	SimpleDateFormat format = new SimpleDateFormat("yyyy년 MM월dd일 HH시mm분ss초");
	String format_time = null;

	public HashMap setFiles(List<MultipartFile> filesList) throws Exception {
		this.files = filesList;
		SIZE = filesList.size();
		GPS = new String[SIZE];
		TIME = new String[SIZE];
		FileVO[] fileVO = new FileVO[SIZE];

		multipartToFile(files);

		for (int j = 0; j < SIZE; j++) {
			fileVO[j] = new FileVO();
			fileVO[j].setGPS(GPS[j]);
			fileVO[j].setTIME(TIME[j]);
			fileVO[j].setPATH(SAVE_PATH);
			fileVOList.add(fileVO[j]);
		}
		HashMap<String, Object> fileMap = new HashMap<String, Object>();
		fileMap.put("fileVOList", fileVOList);

		return fileMap;
	}

	private boolean writeFile(MultipartFile multipartFile, String saveFileName) throws Exception {
		boolean result = false;

		byte[] data = multipartFile.getBytes();
		FileOutputStream fos = new FileOutputStream(SAVE_PATH + "/" + saveFileName);
		fos.write(data);
		fos.close();

		return result;
	}

	private void multipartToFile(List<MultipartFile> multipart) throws Exception {

		for (MultipartFile mF : multipart) {
			String saveFileName = mF.getOriginalFilename();
			writeFile(mF, saveFileName);
			File convFile = new File(saveFileName);
			mF.transferTo(convFile);
			fileMetadata(convFile);

		}

	}

	private void fileMetadata(File file) throws JpegProcessingException {
		try {

			Metadata metadata = JpegMetadataReader.readMetadata(file);
			GpsDirectory gpsDirectory = metadata.getDirectory(GpsDirectory.class);
			ExifSubIFDDirectory directory = metadata.getDirectory(ExifSubIFDDirectory.class);

			GeoLocation exifLocation = gpsDirectory.getGeoLocation();

			Date date = directory.getDate(ExifSubIFDDirectory.TAG_DATETIME_ORIGINAL);

			location = Double.toString(exifLocation.getLatitude()) + " " + Double.toString(exifLocation.getLongitude());

			GPS[i] = location;

			format_time = format.format(date);
			TIME[i] = (format_time);

			i++;

		} catch (IOException ex) {

		}
	}

}
