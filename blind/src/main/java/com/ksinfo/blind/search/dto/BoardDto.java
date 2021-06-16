package com.ksinfo.blind.search.dto;

public class BoardDto {
	//1.BOARD_MGT 토픽(게시판)관리 테이블의 변수
	private String boardTopicName;   	 // board_topic_name character varying(30) not null	//토픽의 이름
	private String boardOrder;  	 	 // board_order integer not null					//토픽의 화면표시순번
	private char   boardAnonymousFlag;   // anonymous_flag character(1) not null			//토픽의 닉네임 마스킹여부(1이면 마스킹)
	private char   boardLogicalDelFlag;  // logical_del_flag character(1) not null			//논리삭제 플래그(1이면 삭제)

	//1.BOARD_MGT 토픽(게시판)관리 관련 get/set함수들	
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
