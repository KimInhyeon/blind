package com.ksinfo.blind.post.vo;

public final class TopicVO {
	private final long boardId;
	private final String boardTopicName;

	public TopicVO(long boardId, String boardTopicName) {
		this.boardId = boardId;
		this.boardTopicName = boardTopicName;
	}

	public long getBoardId() {
		return boardId;
	}

	public String getBoardTopicName() {
		return boardTopicName;
	}
}