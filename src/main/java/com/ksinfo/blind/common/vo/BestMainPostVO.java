package com.ksinfo.blind.common.vo;

public final class BestMainPostVO {
	private final long boardId;
	private final String boardTopicName;
	private final long postId;
	private final String postTitle;
	private final int postRecommendCount;
	private final int replyCount;

	public BestMainPostVO(
		long boardId, String boardTopicName, long postId, String postTitle, int postRecommendCount, int replyCount
	) {
		this.boardId = boardId;
		this.boardTopicName = boardTopicName;
		this.postId = postId;
		this.postTitle = postTitle;
		this.postRecommendCount = postRecommendCount;
		this.replyCount = replyCount;
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

	public int getPostRecommendCount() {
		return postRecommendCount;
	}

	public int getReplyCount() {
		return replyCount;
	}
}