package com.board.domain;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.attribute.PosixFilePermission;
import java.nio.file.attribute.PosixFilePermissions;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Set;
import java.util.UUID;

import org.apache.tika.Tika;
import org.springframework.web.multipart.MultipartFile;

import com.drew.imaging.jpeg.JpegMetadataReader;
import com.drew.imaging.jpeg.JpegProcessingException;
import com.drew.lang.GeoLocation;
import com.drew.metadata.Metadata;
import com.drew.metadata.exif.ExifSubIFDDirectory;
import com.drew.metadata.exif.GpsDirectory;

public class UploadFiles {

	private static final String SAVE_PATH = "/var/Plus/upload";
	private static final String PREFIX_URL = "/img/";
	private int SIZE = 0;
	private int i = 0;
	private int fBno = 0;
	private int userID = 0;

	private List<MultipartFile> files = null;
	private String latitude[];
	private String longitude[];
	private String timeView[];
	private String path[];
	private String fileName[];

	private List<FileVO> fileVOList = new ArrayList<FileVO>();

	SimpleDateFormat formatView = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	String fView = null;

	public HashMap<String, Object> setFiles(List<MultipartFile> filesList, int fileBno, int userID) throws Exception {
		this.files = filesList;
		this.userID = userID;
		// 뙆 씪 닔 꽕 젙
		SIZE = filesList.size();
		fBno = fileBno;

		latitude = new String[SIZE];
		longitude = new String[SIZE];
		timeView = new String[SIZE];
		fileName = new String[SIZE];
		path = new String[SIZE];

		fileWirteEXIF(files);

		return fileVOSet();
	}

	public HashMap<String, Object> imgUpload(List<MultipartFile> filesList, int userID) throws Exception {
		this.files = filesList;
		this.userID = userID;
		// 뙆 씪 닔 꽕 젙
		SIZE = filesList.size();

		latitude = new String[SIZE];
		longitude = new String[SIZE];
		timeView = new String[SIZE];
		fileName = new String[SIZE];
		path = new String[SIZE];

		fileWirteEXIF(files);

		return fileVOSet();
	}

	private HashMap<String, Object> fileVOSet() {
		// TODO Auto-generated method stub
		FileVO[] fileVO = new FileVO[SIZE];
		for (int j = 0; j < SIZE; j++) {
			if (fileName[j] == null) {
				break;
			}
			fileVO[j] = new FileVO();
			fileVO[j].setFileBno(fBno);
			fileVO[j].setLatitude(latitude[j]);
			fileVO[j].setLongitude(longitude[j]);
			fileVO[j].setTimeView(timeView[j]);
			fileVO[j].setFileName(fileName[j]);
			fileVO[j].setPath(path[j]);
			fileVO[j].setUserID(userID);
			fileVOList.add(fileVO[j]);
		}

		HashMap<String, Object> fileMap = new HashMap<String, Object>();
		fileMap.put("fileVOList", fileVOList);

		return fileMap;
	}

	public boolean fileWrite(MultipartFile multipartFile, String saveFileName) throws Exception {
		boolean result = false;

		byte[] data = multipartFile.getBytes();
		FileOutputStream fos = new FileOutputStream(SAVE_PATH + "/" + saveFileName);
		fos.write(data);
		fos.close();

		return result;
	}

	private void fileWirteEXIF(List<MultipartFile> multipart) throws Exception {

		for (MultipartFile mF : multipart) {

			String saveFileName = getRandomString();
			fileWrite(mF, saveFileName);
			File convFile = new File(saveFileName);
			mF.transferTo(convFile);
			filePermissions(SAVE_PATH + "/" + saveFileName);
			fileEXIF(convFile, saveFileName);
		}
	}

	private void filePermissions(String filePath) throws IOException {
		File targetFile = new File(filePath);
		if(targetFile.exists()) {
			 Path path = Paths.get(filePath);
	            Set<PosixFilePermission> posixPermissions = PosixFilePermissions.fromString("rwxrwxrwx");
	            Files.setPosixFilePermissions(path, posixPermissions);
		}
	}
	
	private void fileEXIF(File file, String saveFileName) throws JpegProcessingException {
		try {

			String mimeType = new Tika().detect(file);
			System.out.println("확장자 : " + mimeType);
			if (mimeType.equals("image/jpeg")) {
				Metadata metadata = JpegMetadataReader.readMetadata(file);
				GpsDirectory gpsDirectory = metadata.getDirectory(GpsDirectory.class);
				ExifSubIFDDirectory directory = metadata.getDirectory(ExifSubIFDDirectory.class);

				if (directory != null) {
					Date date = directory.getDate(ExifSubIFDDirectory.TAG_DATETIME_ORIGINAL);
					if (date != null) {

						fView = formatView.format(date);
						timeView[i] = fView;

					} else {
						timeView[i] = "";
					}
				} else {
					timeView[i] = "";
				}

				if (gpsDirectory != null) {
					GeoLocation exifLocation = gpsDirectory.getGeoLocation();
					if (exifLocation != null) {

						latitude[i] = Double.toString(exifLocation.getLatitude());
						longitude[i] = Double.toString(exifLocation.getLongitude());
					}
				} else {
					latitude[i] = "";
					longitude[i] = "";
				}

			} else {
				latitude[i] = "";
				longitude[i] = "";
				timeView[i] = "";
			}
			fileName[i] = saveFileName;
			path[i] = PREFIX_URL + saveFileName;
			i++;

		} catch (IOException ex) {

		}
	}

	public FileVO[] modifyFile(String[] str_id, String[] latitude, String[] longitude, String[] time,
			String[] content) {
		// TODO Auto-generated method stub
		int size = str_id.length;

		FileVO[] modifyVO = new FileVO[size];
		for (int j = 0; j < size; j++) {
			modifyVO[j] = new FileVO();
			modifyVO[j].setId(Integer.parseInt(str_id[j]));
			modifyVO[j].setLatitude(latitude[j].trim());
			modifyVO[j].setLongitude(longitude[j].trim());
			modifyVO[j].setTimeView(time[j].trim());
			modifyVO[j].setContent(content[j]);
		}
		return modifyVO;
	}

	public void deleteFile(String name) {
		// TODO Auto-generated method stub
		File file = new File(SAVE_PATH + "/" + name);
		if (file.exists()) {
			file.delete();
		}
	}

	public String getRandomString() {

		String fileName;
		String saveFileName = UUID.randomUUID().toString().replaceAll("-", "") + ".jpg";

		File file = new File(SAVE_PATH + "\\" + saveFileName);

		while (file.exists()) {
			saveFileName = "0" + saveFileName;
			file = new File(SAVE_PATH + "\\" + saveFileName);
		}

		fileName = saveFileName;

		return fileName;

	}

	public FileVO[] writeClick(int fileBno, String[] id, String[] lat, String[] lon, String[] time, String[] content) {
		// TODO Auto-generated method stub
		int size = id.length;

		FileVO[] modifyVO = new FileVO[size];
		for (int j = 0; j < size; j++) {
			if (id[j] != "") {
				modifyVO[j] = new FileVO();
				modifyVO[j].setFileBno(fileBno);
				modifyVO[j].setId(Integer.parseInt(id[j]));
				modifyVO[j].setLatitude(lat[j].trim());
				modifyVO[j].setLongitude(lon[j].trim());
				modifyVO[j].setTimeView(time[j].trim());
				modifyVO[j].setContent(content[j]);
			}
		}
		return modifyVO;
	}

}