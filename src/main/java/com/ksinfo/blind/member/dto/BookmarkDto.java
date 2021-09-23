package com.ksinfo.blind.member.dto;

public final class BookmarkDto {
	private final long userId;
	private final long postId;

	public BookmarkDto(long userId, long postId) {
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