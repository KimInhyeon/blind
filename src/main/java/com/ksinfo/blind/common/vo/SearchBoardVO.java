package com.ksinfo.blind.common.vo;

public final class SearchBoardVO {
	private final long boardId;
	private final String boardTopicName;
	private final int postCount;

	public SearchBoardVO(long boardId, String boardTopicName, int postCount) {
		this.boardId = boardId;
		this.boardTopicName = boardTopicName;
		this.postCount = postCount;
	}

	public long getBoardId() {
		return boardId;
	}

	public String getBoardTopicName() {
		return boardTopicName;
	}

	public int getPostCount() {
		return postCount;
	}
}