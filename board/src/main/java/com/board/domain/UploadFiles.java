package com.board.domain;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.apache.tika.Tika;
import org.imgscalr.Scalr;
import org.springframework.web.multipart.MultipartFile;

import com.drew.imaging.ImageProcessingException;
import com.drew.imaging.jpeg.JpegMetadataReader;
import com.drew.imaging.jpeg.JpegProcessingException;
import com.drew.lang.GeoLocation;
import com.drew.metadata.Metadata;
import com.drew.metadata.MetadataException;
import com.drew.metadata.exif.ExifIFD0Directory;
import com.drew.metadata.exif.ExifSubIFDDirectory;
import com.drew.metadata.exif.GpsDirectory;

public class UploadFiles {

	private static final String SAVE_PATH = "C:/var/Plus/upload/";

	private Calendar cal = Calendar.getInstance();
	public String PATH = String.format("%04d/%02d/%02d/", cal.get(Calendar.YEAR), cal.get(Calendar.MONTH) + 1,
			cal.get(Calendar.DAY_OF_MONTH));

	private String[] thumb = { "view/", "slider/", "square/", "thumb/" };

	private Metadata metadata = null;

	private int orientation = 0;
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

	public void fileWrite(MultipartFile multipartFile, String saveFileName) throws Exception {

		byte[] data = multipartFile.getBytes();
		FileOutputStream fos = new FileOutputStream(SAVE_PATH + PATH + saveFileName);
		fos.write(data);
		fos.close();

	}

	private void fileWirteEXIF(List<MultipartFile> multipart) throws Exception {

		for (MultipartFile mF : multipart) {

			String saveFileName = getRandomString();
			fileWrite(mF, saveFileName);
			File convFile = new File(SAVE_PATH + PATH + saveFileName);
			mF.transferTo(convFile);
			fileEXIF(convFile, saveFileName);
			makeThumbnail(saveFileName, "img");
		}
	}

	private void fileEXIF(File file, String saveFileName) throws MetadataException, ImageProcessingException {
		try {
			if (checkJpeg(file)) {
				metadata = getMetadata(file);
				orientation = getOrientation(file);
				getImgDate();
				getImgGps();
			} else {
				latitude[i] = "";
				longitude[i] = "";
				timeView[i] = "";
			}
			fileName[i] = saveFileName;
			path[i] = "/img/" + PATH;
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
		File[] file = new File[5];
		file[0] = new File(SAVE_PATH + PATH + name);
		file[1] = new File(SAVE_PATH + PATH + thumb[0] + name);
		file[2] = new File(SAVE_PATH + PATH + thumb[1] + name);
		file[3] = new File(SAVE_PATH + PATH + thumb[2] + name);
		file[4] = new File(SAVE_PATH + PATH + thumb[3] + name);

		for (File f : file) {
			if (f.exists()) {
				f.delete();
				System.out.println("이미지 존재 : " + f.exists() + " 삭제 경로 : " + f.getPath());
			}
		}

	}

	public String getRandomString() {
//		String[] fileName = new String[2];

		String[] dirName = new String[5];

		dirName[0] = SAVE_PATH + PATH;
		dirName[1] = SAVE_PATH + PATH + thumb[0];
		dirName[2] = SAVE_PATH + PATH + thumb[1];
		dirName[3] = SAVE_PATH + PATH + thumb[2];
		dirName[4] = SAVE_PATH + PATH + thumb[3];

//		dirName[0] = String.format(SAVE_PATH + "%04d/%02d/%02d", cal.get(Calendar.YEAR), cal.get(Calendar.MONTH) + 1,
//				cal.get(Calendar.DAY_OF_MONTH));
//		dirName[1] = String.format(SAVE_THUMB_PATH + "%04d/%02d/%02d", cal.get(Calendar.YEAR),
//				cal.get(Calendar.MONTH) + 1, cal.get(Calendar.DAY_OF_MONTH));
//
//		fileName[0] = String.format("%04d/%02d/%02d/", cal.get(Calendar.YEAR), cal.get(Calendar.MONTH) + 1,
//				cal.get(Calendar.DAY_OF_MONTH));
//		fileName[1] = String.format("%04d/%02d/%02d/", cal.get(Calendar.YEAR), cal.get(Calendar.MONTH) + 1,
//				cal.get(Calendar.DAY_OF_MONTH));

		for(String dir : dirName) {
			File f = new File(dir);
			f.mkdirs();
		}

		String saveFileName = UUID.randomUUID().toString().replaceAll("-", "") + ".jpg";

		File file = new File(dirName[0] + saveFileName);

		while (file.exists()) {
			saveFileName = "0" + saveFileName;
			file = new File(dirName[0] + saveFileName);
		}

//		System.out.println(fileName[0] + ", " + fileName[1]);
		System.out.println(saveFileName);
		return saveFileName;

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

	public void deleteFileList(List<String> fileNameList) {
		// TODO Auto-generated method stub
		for (String name : fileNameList) {
			deleteFile(name);
		}
	}

	public void makeThumbnail(String fileName, String tag) throws Exception {
		BufferedImage srcImg = null;
		if (tag.equals("img")) {
			srcImg = ImageIO.read(new File(SAVE_PATH + PATH + fileName));
			srcImg = thumbOrientation(srcImg, orientation);

			// 뷰 425 260
			// 슬라이드 316 210
			// 프로필 300 300
			int[] dw = { 425, 316, 300 };
			int[] dh = { 260, 210, 300 };
			int ow = srcImg.getWidth();
			int oh = srcImg.getHeight();

			int[] nw = new int[3];
			int[] nh = new int[3];
			for (int i = 0; i < 3; i++) {
				
				nw[i] = ow;
				nh[i] = (ow * dh[i]) / dw[i];

				if (nh[i] > oh) {
					nw[i] = (oh * dw[i]) / dh[i];
					nh[i] = oh;
				}

				BufferedImage cropImg = Scalr.crop(srcImg, (ow - nw[i]) / 2, (oh - nh[i]) / 2, nw[i], nh[i]);
				BufferedImage destImg = Scalr.resize(cropImg, dw[i], dh[i]);

				File thumbFile = null;

				thumbFile = new File(SAVE_PATH + PATH + thumb[i] + fileName);
				ImageIO.write(destImg, "jpg", thumbFile);
			}
			
			if(ow > oh) {
				ow = dw[0];
				oh = ow/dw[0];
			} else {
				ow = oh/dh[0];
				oh = dh[0];
			}
			BufferedImage destImg = Scalr.resize(srcImg, ow, oh);
			File thumbFile = null;

			thumbFile = new File(SAVE_PATH + PATH + thumb[3] + fileName);
			ImageIO.write(destImg, "jpg", thumbFile);

		} else if (tag.equals("profile")) {
			srcImg = ImageIO.read(new File(SAVE_PATH + PATH + fileName));
			metadata = getMetadata(new File(SAVE_PATH + PATH + fileName));
			orientation = getOrientation(new File(SAVE_PATH + PATH + fileName));
			if (orientation >= 0) {
				srcImg = thumbOrientation(srcImg, orientation);
			}
			int dw = 300;
			int dh = 300;
			int ow = srcImg.getWidth();
			int oh = srcImg.getHeight();

			int nw = 0;
			int nh = 0;

			nw = ow;
			nh = (ow * dh) / dw;

			if (nh > oh) {
				nw = (oh * dw) / dh;
				nh = oh;
			}

			BufferedImage cropImg = Scalr.crop(srcImg, (ow - nw) / 2, (oh - nh) / 2, nw, nh);
			BufferedImage destImg = Scalr.resize(cropImg, dw, dh);

			File thumbFile = null;

			thumbFile = new File(SAVE_PATH + PATH + fileName);
			ImageIO.write(destImg, "jpg", thumbFile);

		}
	}

	private BufferedImage thumbOrientation(BufferedImage srcImg, int orientation) {
		switch (orientation) {
		case 3:
			srcImg = Scalr.rotate(srcImg, Scalr.Rotation.CW_180);
			break;
		case 6:
			srcImg = Scalr.rotate(srcImg, Scalr.Rotation.CW_90);
			break;
		case 8:
			srcImg = Scalr.rotate(srcImg, Scalr.Rotation.CW_270);
		default:
			break;
		}

		return srcImg;
	}

	private int getOrientation(File filePath) throws MetadataException, JpegProcessingException, IOException {
		ExifIFD0Directory dir = metadata.getDirectory(ExifIFD0Directory.class);
		if (dir != null && dir.containsTag(ExifIFD0Directory.TAG_ORIENTATION)) {
			orientation = dir.getInt(ExifIFD0Directory.TAG_ORIENTATION);
		}

		return orientation;
	}

	private void getImgDate() {
		ExifSubIFDDirectory dir = metadata.getDirectory(ExifSubIFDDirectory.class);
		if (dir != null && dir.containsTag(ExifSubIFDDirectory.TAG_DATETIME_ORIGINAL)) {

			Date date = dir.getDate(ExifSubIFDDirectory.TAG_DATETIME_ORIGINAL);
			if (date != null) {

				fView = formatView.format(date);
				timeView[i] = fView;
				System.out.println("fView : " + fView);

			} else {
				System.out.println("data 없음");
				timeView[i] = "";
			}
		} else {
			System.out.println("directory 없음");
			timeView[i] = "";
		}
	}

	private void getImgGps() {
		GpsDirectory gpsDirectory = metadata.getDirectory(GpsDirectory.class);
		if (gpsDirectory != null) {
			GeoLocation exifLocation = gpsDirectory.getGeoLocation();
			if (exifLocation != null) {
				latitude[i] = Double.toString(exifLocation.getLatitude());
				longitude[i] = Double.toString(exifLocation.getLongitude());
				System.out.println("latitude, longitude : " + latitude + ", " + longitude);
			} else {
				latitude[i] = "";
				longitude[i] = "";
				System.out.println("exifLocation 없음");
			}
		} else {
			latitude[i] = "";
			longitude[i] = "";
			System.out.println("gpsDirectory 없음");
		}

	}

	private boolean checkJpeg(File filePath) throws IOException {
		String mimeType = new Tika().detect(filePath);
		if (mimeType.equals("image/jpeg")) {
			return true;
		} else {
			return false;
		}
	}

	private Metadata getMetadata(File filePath) throws JpegProcessingException, IOException {
		Metadata metadata = JpegMetadataReader.readMetadata(filePath);
		return metadata;
	}

}