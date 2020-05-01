package com.board.domain;

import com.drew.lang.annotations.NotNull;


public class FileVO {

	private int fileBno;
	private String gps;
	private String timeView;
	private String timeSort;
	private String path;
	
	
	public int getfileBno() {
		return fileBno;
	}
	public void setfileBno(int fileBno) {
		this.fileBno = fileBno;
	}
	public String getGps() {
		return gps;
	}
	public void setGps(String gps) {
		this.gps = gps;
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
