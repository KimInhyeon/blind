package com.ksinfo.blind.topicMain.dto;

import java.util.Date;

public class TopicMainDto {
	private long boardId;
	private String boardTopicName;
	private int boardOrder;
	private char closedFlag;
	private char anonymousFlag;
	private Date boardCreateDate;
	private Date boardUpdateDate;

	public long getBoardId() {
		return boardId;
	}

	public void setBoardId(long boardId) {
		this.boardId = boardId;
	}

	public String getBoardTopicName() {
		return boardTopicName;
	}

	public void setBoardTopicName(String boardTopicName) {
		this.boardTopicName = boardTopicName;
	}

	public int getBoardOrder() {
		return boardOrder;
	}

	public void setBoardOrder(int boardOrder) {
		this.boardOrder = boardOrder;
	}

	public char getClosedFlag() {
		return closedFlag;
	}

	public void setClosedFlag(char closedFlag) {
		this.closedFlag = closedFlag;
	}

	public char getAnonymousFlag() {
		return anonymousFlag;
	}

	public void setAnonymousFlag(char anonymousFlag) {
		this.anonymousFlag = anonymousFlag;
	}

	public Date getBoardCreateDate() {
		return boardCreateDate;
	}

	public void setBoardCreateDate(Date boardCreateDate) {
		this.boardCreateDate = boardCreateDate;
	}

	public Date getBoardUpdateDate() {
		return boardUpdateDate;
	}

	public void setBoardUpdateDate(Date boardUpdateDate) {
		this.boardUpdateDate = boardUpdateDate;
	}

}
