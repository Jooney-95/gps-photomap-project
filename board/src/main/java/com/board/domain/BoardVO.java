package com.board.domain;

import java.util.Date;

import com.drew.lang.annotations.NotNull;

@NotNull
public class BoardVO {
	private int bno;
	private String title;
	private int writer;
	private Date regDate;
	private int viewCnt;
	private int pNum;
	private int likeCnt;
	private String kate;
	
	public int getLikeCnt() {
		return likeCnt;
	}
	public void setLikeCnt(int likeCnt) {
		this.likeCnt = likeCnt;
	}
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
	public int getWriter() {
		return writer;
	}
	public void setWriter(int writer) {
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
	public String getKate() {
		return kate;
	}
	public void setKate(String kate) {
		this.kate = kate;
	}

}
