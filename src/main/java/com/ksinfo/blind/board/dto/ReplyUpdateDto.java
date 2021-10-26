package com.ksinfo.blind.board.dto;

public final class ReplyUpdateDto {
	private long userId;
	private final long replyId;
	private final String replyFileUrl;
	private final String replyContents;

	public ReplyUpdateDto(long replyId, String replyFileUrl, String replyContents) {
		this.replyId = replyId;
		this.replyFileUrl = replyFileUrl;
		this.replyContents = replyContents;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public long getUserId() {
		return userId;
	}

	public long getReplyId() {
		return replyId;
	}

	public String getReplyFileUrl() {
		return replyFileUrl;
	}

	public String getReplyContents() {
		return replyContents;
	}
}