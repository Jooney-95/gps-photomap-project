package com.board.domain;

import java.util.Date;

import com.drew.lang.annotations.NotNull;

@NotNull
public class BoardVO {
	private int bno;
	private String title;
	private String writer;
	private Date regDate;
	private int viewCnt;
	private int pNum;
	
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getTitle() {
		return title.replaceAll("(?i)<script", "&lt;script");
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getWriter() {
		return writer.replaceAll("(?i)<script", "&lt;script");
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public int getViewCnt() {
		return viewCnt;
	}
	public void setViewCnt(int viewCnt) {
		this.viewCnt = viewCnt;
	}
	public int getpNum() {
		return pNum;
	}
	public void setpNum(int pNum) {
		this.pNum = pNum;
	}

}
