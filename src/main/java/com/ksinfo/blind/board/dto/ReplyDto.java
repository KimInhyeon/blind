package com.ksinfo.blind.board.dto;

public final class ReplyDto {
	private long userId;
	private final long postId;
	private final Long targetReplyId;
	private final String replyFileUrl;
	private final String replyContents;
	private final char replyBlindFlag;

	public ReplyDto(long postId, Long targetReplyId, String replyFileUrl, String replyContents, char replyBlindFlag) {
		this.postId = postId;
		this.targetReplyId = targetReplyId;
		this.replyFileUrl = replyFileUrl;
		this.replyContents = replyContents;
		this.replyBlindFlag = replyBlindFlag;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public long getUserId() {
		return userId;
	}

	public long getPostId() {
		return postId;
	}

	public Long getTargetReplyId() {
		return targetReplyId;
	}

	public String getReplyFileUrl() {
		return replyFileUrl;
	}

	public String getReplyContents() {
		return replyContents;
	}

	public char getReplyBlindFlag() {
		return replyBlindFlag;
	}
}