package com.ksinfo.blind.board.dto;

public class ReplyRequestDto {
	private final long userId;
	private final long postId;

	public ReplyRequestDto(long userId, long postId) {
		this.userId = userId;
		this.postId = postId;
	}

	public final long getUserId() {
		return userId;
	}

	public final long getPostId() {
		return postId;
	}
}