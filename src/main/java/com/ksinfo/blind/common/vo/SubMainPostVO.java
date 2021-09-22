package com.ksinfo.blind.common.vo;

public final class SubMainPostVO {
	private final long boardId;
	private final String boardTopicName;
	private final long postId;
	private final String postTitle;
	private final int postCount;

	public SubMainPostVO(long boardId, String boardTopicName, long postId, String postTitle, int postCount) {
		this.boardId = boardId;
		this.boardTopicName = boardTopicName;
		this.postId = postId;
		this.postTitle = postTitle;
		this.postCount = postCount;
	}

	public long getBoardId() {
		return boardId;
	}

	public String getBoardTopicName() {
		return boardTopicName;
	}

	public long getPostId() {
		return postId;
	}

	public String getPostTitle() {
		return postTitle;
	}

	public int getPostCount() {
		return postCount;
	}
}