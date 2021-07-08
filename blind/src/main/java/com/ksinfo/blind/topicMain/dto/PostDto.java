package com.ksinfo.blind.topicMain.dto;

import java.util.Date;

public class PostDto {
	private long postId;
	private long userId;
	private String postTitle;
	private char postBlindFlag;
	private String postContents;
	private Date postCreateDate;
	private Date postUpdateDate;
	private String boardTopicName;
	private long postCountId;
	private long postCount;
	private String companyName;

	public long getPostId() {
		return postId;
	}

	public void setPostId(long postId) {
		this.postId = postId;
	}

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public String getPostTitle() {
		return postTitle;
	}

	public void setPostTitle(String postTitle) {
		this.postTitle = postTitle;
	}

	public char getPostBlindFlag() {
		return postBlindFlag;
	}

	public void setPostBlindFlag(char postBlindFlag) {
		this.postBlindFlag = postBlindFlag;
	}

	public String getPostContents() {
		return postContents;
	}

	public void setPostContents(String postContents) {
		this.postContents = postContents;
	}

	public Date getPostCreateDate() {
		return postCreateDate;
	}

	public void setPostCreateDate(Date postCreateDate) {
		this.postCreateDate = postCreateDate;
	}

	public Date getPostUpdateDate() {
		return postUpdateDate;
	}

	public void setPostUpdateDate(Date postUpdateDate) {
		this.postUpdateDate = postUpdateDate;
	}

	public String getBoardTopicName() {
		return boardTopicName;
	}

	public void setBoardTopicName(String boardTopicName) {
		this.boardTopicName = boardTopicName;
	}

	public long getPostCountId() {
		return postCountId;
	}

	public void setPostCountId(long postCountId) {
		this.postCountId = postCountId;
	}

	public long getPostCount() {
		return postCount;
	}

	public void setPostCount(long postCount) {
		this.postCount = postCount;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	
}
