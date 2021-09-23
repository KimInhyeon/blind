package com.ksinfo.blind.board.vo;

public final class BoardVO {
	private final long boardId;
	private final String boardTopicName;

	public BoardVO(long boardId, String boardTopicName) {
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