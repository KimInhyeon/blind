package com.ksinfo.blind.board.dto;

public final class PostFileDto {
	private final long userId;
	private final long postId;
	private final String postFileUrl;
	private final String postFileOriginName;
	private final long postFileSize;

	public PostFileDto(long userId, long postId, String postFileUrl, String postFileOriginName, long postFileSize) {
		this.userId = userId;
		this.postId = postId;
		this.postFileUrl = postFileUrl;
		this.postFileOriginName = postFileOriginName;
		this.postFileSize = postFileSize;
	}

	public long getUserId() {
		return userId;
	}

	public long getPostId() {
		return postId;
	}

	public String getPostFileUrl() {
		return postFileUrl;
	}

	public String getPostFileOriginName() {
		return postFileOriginName;
	}

	public long getPostFileSize() {
		return postFileSize;
	}
}