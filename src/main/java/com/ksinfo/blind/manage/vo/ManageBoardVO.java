package com.ksinfo.blind.manage.vo;

public final class ManageBoardVO {
	private final long boardId;
	private final String boardTopicName;
	private final int boardOrder;
	private final char closedFlag;
	private final char anonymousFlag;

	public ManageBoardVO(long boardId, String boardTopicName, int boardOrder, char closedFlag, char anonymousFlag) {
		this.boardId = boardId;
		this.boardTopicName = boardTopicName;
		this.boardOrder = boardOrder;
		this.closedFlag = closedFlag;
		this.anonymousFlag = anonymousFlag;
	}

	public long getBoardId() {
		return boardId;
	}

	public String getBoardTopicName() {
		return boardTopicName;
	}

	public int getBoardOrder() {
		return boardOrder;
	}

	public char getClosedFlag() {
		return closedFlag;
	}

	public char getAnonymousFlag() {
		return anonymousFlag;
	}
}