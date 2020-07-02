package com.board.domain;

import java.util.Date;

public class FollowVO {

	private int id;
	private int userID;
	private int following;
	private int fforf;
	private Date folDate;
	
	public Date getFolDate() {
		return folDate;
	}
	public void setFolDate(Date folDate) {
		this.folDate = folDate;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUserID() {
		return userID;
	}
	public void setUserID(int userID) {
		this.userID = userID;
	}
	public int getFollowing() {
		return following;
	}
	public void setFollowing(int following) {
		this.following = following;
	}
	public int getFforf() {
		return fforf;
	}
	public void setFforf(int fforf) {
		this.fforf = fforf;
	}
	
	
}
