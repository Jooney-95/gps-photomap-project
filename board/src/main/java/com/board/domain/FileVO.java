package com.board.domain;

public class FileVO {

	private int id;
	
	private int fileBno;
	private String latitude;
	private String longitude;
	private String timeView;
	private String place;
	
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}
	private String content;
	private int userID;
	
	
	public int getFileBno() {
		return fileBno;
	}
	public void setFileBno(int fileBno) {
		this.fileBno = fileBno;
	}
	public int getUserID() {
		return userID;
	}
	public void setUserID(int userID) {
		this.userID = userID;
	}
	public String getLatitude() {
		return latitude.replaceAll("(?i)<script", "&lt;script");
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude.replaceAll("(?i)<script", "&lt;script");
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	private String path;
	private String fileName;
	
	public String getFileName() {
		return fileName.replaceAll("(?i)<script", "&lt;script");
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
	public String getTimeView() {
		return timeView.replaceAll("(?i)<script", "&lt;script");
	}
	public void setTimeView(String timeView) {
		this.timeView = timeView;
	}
	public String getContent() {
		return content.replaceAll("(?i)<script", "&lt;script");
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	
	
	
}
