package com.board.domain;

import com.drew.lang.annotations.NotNull;


public class FileVO {

	private int fileBno;
	private Double latitude; // 위도
	private Double longitude; // 경도
	private String timeView;
	private String timeSort;
	private String path;
	private int id;
	
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
	public int getId() {
	      return id;
	   }
	public void setId(int id) {
	      this.id = id;
	   }
	public Double getLatitude() {
		return latitude;
	}
	public void setLatitude(Double latitude) {
		this.latitude = latitude;
	}
	public Double getLongitude() {
		return longitude;
	}
	public void setLongitude(Double longitude) {
		this.longitude = longitude;
	}
	
}
