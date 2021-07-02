package com.ksinfo.blind.manage.dto;

public class BoardCreateDto {
	private String boardTopicName;
	private int boardOrder;
	private char anonymousFlag;
	private long userId;

	public BoardCreateDto(String boardTopicName, int boardOrder, char anonymousFlag) {
		this.boardTopicName = boardTopicName;
		this.boardOrder = boardOrder;
		this.anonymousFlag = anonymousFlag;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public String getBoardTopicName() {
		return boardTopicName;
	}

	public int getBoardOrder() {
		return boardOrder;
	}

	public char getAnonymousFlag() {
		return anonymousFlag;
	}

	public long getUserId() {
		return userId;
	}
}