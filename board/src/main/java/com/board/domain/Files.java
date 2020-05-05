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
import org.apache.commons.io.FilenameUtils;

import com.drew.imaging.jpeg.JpegMetadataReader;
import com.drew.imaging.jpeg.JpegProcessingException;
import com.drew.lang.GeoLocation;
import com.drew.metadata.Metadata;
import com.drew.metadata.exif.ExifSubIFDDirectory;
import com.drew.metadata.exif.GpsDirectory;

public class Files {

	private static final String SAVE_PATH = "C:\\Users\\skyhu\\Desktop\\fileUpload";
	private static final String PREFIX_URL = "/img/";
	private int SIZE = 0;
	private int i = 0;
	private int fBno = 0;

	private List<MultipartFile> files = null;
	private String gps[];
	private String timeView[];
	private String timeSort[];
	private String path[];
	private String fileName[];
	private String location;
	private List<FileVO> fileVOList = new ArrayList<FileVO>();

	SimpleDateFormat formatView = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	SimpleDateFormat formatSort = new SimpleDateFormat("yyyyMMddHHmmSSSS");
	String fView = null;
	String fSort = null;

	public HashMap<String, Object> setFiles(List<MultipartFile> filesList, int fileBno) throws Exception {
		this.files = filesList;

		// 파일 수 설정
		SIZE = filesList.size();
		fBno = fileBno;

		gps = new String[SIZE];
		timeView = new String[SIZE];
		timeSort = new String[SIZE];
		fileName = new String[SIZE];
		path = new String[SIZE];

		fileWirteEXIF(files);

		return fileVOSet();
	}
	
	
	private HashMap<String, Object> fileVOSet() {
		// TODO Auto-generated method stub
		FileVO[] fileVO = new FileVO[SIZE];
		for (int j = 0; j < SIZE; j++) {
			fileVO[j] = new FileVO();
			fileVO[j].setfileBno(fBno);
			fileVO[j].setGps(gps[j]);
			fileVO[j].setTimeView(timeView[j]);
			fileVO[j].setTimeSort(timeSort[j]);
			fileVO[j].setFileName(fileName[j]);
			fileVO[j].setPath(path[j]);
			fileVOList.add(fileVO[j]);
		}

		HashMap<String, Object> fileMap = new HashMap<String, Object>();
		fileMap.put("fileVOList", fileVOList);

		return fileMap;
	}

	private boolean fileWrite(MultipartFile multipartFile, String saveFileName) throws Exception {
		boolean result = false;

		byte[] data = multipartFile.getBytes();
		FileOutputStream fos = new FileOutputStream(SAVE_PATH + "/" + saveFileName);
		fos.write(data);
		fos.close();

		return result;
	}

	private void fileWirteEXIF(List<MultipartFile> multipart) throws Exception {

		for (MultipartFile mF : multipart) {
			String saveFileName = mF.getOriginalFilename();
			fileWrite(mF, saveFileName);
			File convFile = new File(saveFileName);
			mF.transferTo(convFile);
			fileEXIF(convFile, saveFileName);

		}

	}

	private void fileEXIF(File file, String saveFileName) throws JpegProcessingException {
		try {
			String extension = FilenameUtils.getExtension(file.getPath());
			if (extension.equals("jpg") || extension.equals("jpeg")) {
				Metadata metadata = JpegMetadataReader.readMetadata(file);
				GpsDirectory gpsDirectory = metadata.getDirectory(GpsDirectory.class);
				ExifSubIFDDirectory directory = metadata.getDirectory(ExifSubIFDDirectory.class);

				if (directory != null) {

					GeoLocation exifLocation = gpsDirectory.getGeoLocation();
					Date date = directory.getDate(ExifSubIFDDirectory.TAG_DATETIME_ORIGINAL);

					location = Double.toString(exifLocation.getLatitude()) + " "
							+ Double.toString(exifLocation.getLongitude());
					gps[i] = location;

					fView = formatView.format(date);
					fSort = formatSort.format(date);
					timeView[i] = fView;
					timeSort[i] = fSort;
					fileName[i] = saveFileName;
					path[i] = PREFIX_URL + saveFileName;
					i++;
				} else {
					gps[i] = " ";
					timeView[i] = " ";
					timeSort[i] = " ";
					fileName[i] = saveFileName;
					path[i] = PREFIX_URL + saveFileName;
					i++;
				}
			} else {
				gps[i] = " ";
				timeView[i] = " ";
				timeSort[i] = " ";
				fileName[i] = saveFileName;
				path[i] = PREFIX_URL + saveFileName;
				i++;
			}
		} catch (IOException ex) {
	
		}
	}


	public FileVO[] modifyFile(String[] str_id, String[] gps, String[] time) {
		// TODO Auto-generated method stub
		int size = str_id.length;
		
		FileVO[] modifyVO = new FileVO[size];
		for (int j = 0; j < size; j++) {
			modifyVO[j] = new FileVO();
			modifyVO[j].setId(Integer.parseInt(str_id[j]));
			modifyVO[j].setGps(gps[j]);
			modifyVO[j].setTimeView(time[j]);
		}
		return modifyVO;
	}

	public void deleteFile(String name) {
		// TODO Auto-generated method stub
		File file = new File(SAVE_PATH + "/" + name);
		if(file.exists()) {
			file.delete();
		}
	}

}
