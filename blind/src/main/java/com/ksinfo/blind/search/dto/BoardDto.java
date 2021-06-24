package com.ksinfo.blind.search.dto;

public class BoardDto {
	//1.BOARD_MGT ����(�Խ���)���� ���̺��� ����
	private int 	boardId;
	private String  boardTopicName;   	 // board_topic_name character varying(30) not null	//������ �̸�
	private String  boardOrder;  	 	 // board_order integer not null					//������ ȭ��ǥ�ü���
	private char    anonymousFlag;   // anonymous_flag character(1) not null			//������ �г��� ����ŷ����(1�̸� ����ŷ)
	private char    logicalDelFlag;  // logical_del_flag character(1) not null			//������ �÷���(1�̸� ����)
	private int 	postCount;
	
	
	// get/set �ޙ���
	
	public String getBoardTopicName() {
		return boardTopicName;
	}

	public int getPostCount() {
		return postCount;
	}

	public void setPostCount(int postCount) {
		this.postCount = postCount;
	}

	public int getBoardId() {
		return boardId;
	}

	public void setBoardId(int boardId) {
		this.boardId = boardId;
	}

	public char getAnonymousFlag() {
		return anonymousFlag;
	}

	public void setAnonymousFlag(char anonymousFlag) {
		this.anonymousFlag = anonymousFlag;
	}

	public char getLogicalDelFlag() {
		return logicalDelFlag;
	}

	public void setLogicalDelFlag(char logicalDelFlag) {
		this.logicalDelFlag = logicalDelFlag;
	}

	public void setBoardTopicName(String boardTopicName) {
		this.boardTopicName = boardTopicName;
	}
	
	public String getBoardOrder() {
		return boardOrder;
	}

	public void setBoardOrder(String boardOrder) {
		this.boardOrder = boardOrder;
	}

	public char getBoardAnonymousFlag() {
		return anonymousFlag;
	}

	public void setBoardAnonymousFlag(char boardAnonymousFlag) {
		this.anonymousFlag = boardAnonymousFlag;
	}

	public char getBoardLogicalDelFlag() {
		return logicalDelFlag;
	}

	public void setBoardLogicalDelFlag(char boardLogicalDelFlag) {
		this.logicalDelFlag = boardLogicalDelFlag;
	}
}
