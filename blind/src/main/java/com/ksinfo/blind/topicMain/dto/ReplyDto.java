package com.ksinfo.blind.topicMain.dto;

import java.sql.Date;

public class ReplyDto {

	private long replyId;
	private long postId;
	private long targetReplyId;
	private long userId;
	private String replyContents;
	private char replyBlindFlag;
	private Date recCreateDate;
	private char logicalDelFlag;
	private String companyName;
	private long replyCount;

	public long getReplyId() {
		return replyId;
	}

	public void setReplyId(long replyId) {
		this.replyId = replyId;
	}

	public long getPostId() {
		return postId;
	}

	public void setPostId(long postId) {
		this.postId = postId;
	}

	public long getTargetReplyId() {
		return targetReplyId;
	}

	public void setTargetReplyId(long targetReplyId) {
		this.targetReplyId = targetReplyId;
	}

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public String getReplyContents() {
		return replyContents;
	}

	public void setReplyContents(String replyContents) {
		this.replyContents = replyContents;
	}

	public char getReplyBlindFlag() {
		return replyBlindFlag;
	}

	public void setReplyBlindFlag(char replyBlindFlag) {
		this.replyBlindFlag = replyBlindFlag;
	}

	public Date getRecCreateDate() {
		return recCreateDate;
	}

	public void setRecCreateDate(Date recCreateDate) {
		this.recCreateDate = recCreateDate;
	}

	public char getLogicalDelFlag() {
		return logicalDelFlag;
	}

	public void setLogicalDelFlag(char logicalDelFlag) {
		this.logicalDelFlag = logicalDelFlag;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public long getReplyCount() {
		return replyCount;
	}

	public void setReplyCount(long replyCount) {
		this.replyCount = replyCount;
	}
}