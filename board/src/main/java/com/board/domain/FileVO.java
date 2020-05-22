package com.board.domain;

public class FileVO {

	private int id;
	private int fileBno;
	private String latitude;
	private String longitude;
	private String timeView;
	private String timeSort;
	private String path;
	private String fileName;
	
	
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getfileBno() {
		return fileBno;
	}
	public void setfileBno(int fileBno) {
		this.fileBno = fileBno;
	}
	public String getTimeView() {
		return timeView;
	}
	public void setTimeView(String timeView) {
		this.timeView = timeView;
	}
	public String getTimeSort() {
		return timeSort;
	}
	public void setTimeSort(String timeSort) {
		this.timeSort = timeSort;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	
	
	
}
