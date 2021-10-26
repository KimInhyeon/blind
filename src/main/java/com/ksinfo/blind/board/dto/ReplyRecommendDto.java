package com.ksinfo.blind.board.dto;

public final class ReplyRecommendDto {
	private final long userId;
	private final long replyId;

	public ReplyRecommendDto(long userId, long replyId) {
		this.userId = userId;
		this.replyId = replyId;
	}

	public long getUserId() {
		return userId;
	}

	public long getReplyId() {
		return replyId;
	}
}