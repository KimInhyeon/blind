package com.ksinfo.blind.search.dto;

public class ReplyDto {
	//"blind".REPLY_MGT
	private String replyId; //reply_id bigint GENERATED ALWAYS AS IDENTITY
	private int postId; //, post_id bigint not null
	private int targetReplyId; //, target_reply_id bigint
	private int userId; //, user_id bigint not null
	private String replyContents; //, reply_contents character varying(400) not null
	private char replyBlindFlag; //, reply_blind_flag character(1) not null
	private char logicalDelFlag; //, logical_del_flag character(1) not null

	public String getReplyId() {
		return replyId;
	}

	public void setReplyId(String replyId) {
		this.replyId = replyId;
	}

	public int getPostId() {
		return postId;
	}

	public void setPostId(int postId) {
		this.postId = postId;
	}

	public int getTargetReplyId() {
		return targetReplyId;
	}

	public void setTargetReplyId(int targetReplyId) {
		this.targetReplyId = targetReplyId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
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

	public char getLogicalDelFlag() {
		return logicalDelFlag;
	}

	public void setLogicalDelFlag(char logicalDelFlag) {
		this.logicalDelFlag = logicalDelFlag;
	}
}