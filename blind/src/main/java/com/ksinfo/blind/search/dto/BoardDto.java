package com.ksinfo.blind.search.dto;

public class BoardDto {
	//1.BOARD_MGT ����(�Խ���)���� ���̺��� ����
	private String boardTopicName;   	 // board_topic_name character varying(30) not null	//������ �̸�
	private String boardOrder;  	 	 // board_order integer not null					//������ ȭ��ǥ�ü���
	private char   boardAnonymousFlag;   // anonymous_flag character(1) not null			//������ �г��� ����ŷ����(1�̸� ����ŷ)
	private char   boardLogicalDelFlag;  // logical_del_flag character(1) not null			//������ �÷���(1�̸� ����)

	//1.BOARD_MGT ����(�Խ���)���� ���� get/set�Լ���	
	public String getBoardTopicName() {
		return boardTopicName;
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
		return boardAnonymousFlag;
	}

	public void setBoardAnonymousFlag(char boardAnonymousFlag) {
		this.boardAnonymousFlag = boardAnonymousFlag;
	}

	public char getBoardLogicalDelFlag() {
		return boardLogicalDelFlag;
	}

	public void setBoardLogicalDelFlag(char boardLogicalDelFlag) {
		this.boardLogicalDelFlag = boardLogicalDelFlag;
	}
}
