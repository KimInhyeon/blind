package com.ksinfo.blind.manage.dto;

public class BoardUpdateDto {
	private long boardId;
	private String boardTopicName;
	private int boardOrder;
	private char closedFlag;
	private char anonymousFlag;
	private long userId;

	public BoardUpdateDto(long boardId, String boardTopicName, int boardOrder, char closedFlag, char anonymousFlag) {
		this.boardId = boardId;
		this.boardTopicName = boardTopicName;
		this.boardOrder = boardOrder;
		this.closedFlag = closedFlag;
		this.anonymousFlag = anonymousFlag;
	}

	public void setUserId(long userId) {
		this.userId = userId;
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

	public long getUserId() {
		return userId;
	}
}