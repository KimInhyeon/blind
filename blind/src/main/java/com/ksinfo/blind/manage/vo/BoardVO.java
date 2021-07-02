package com.ksinfo.blind.manage.vo;

public class BoardVO {
	private long boardId;
	private String boardTopicName;
	private int boardOrder;
	private char closedFlag;
	private char anonymousFlag;

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