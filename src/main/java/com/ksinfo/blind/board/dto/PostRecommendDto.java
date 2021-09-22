package com.ksinfo.blind.board.dto;

public final class PostRecommendDto {
	private final long userId;
	private final long postId;

	public PostRecommendDto(long userId, long postId) {
		this.userId = userId;
		this.postId = postId;
	}

	public long getUserId() {
		return userId;
	}

	public long getPostId() {
		return postId;
	}
}