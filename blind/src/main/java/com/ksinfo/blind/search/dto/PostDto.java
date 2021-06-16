package com.ksinfo.blind.search.dto;

public class PostDto {
	
	//2.POST_MGT //�Խñ۰��� ���̺��� ����
	private String userId;				 //user_id bigint 					  	   //�Խñ� �ۼ� ������ id.�����ε尡 �ƴ϶�, �ۼ������� ��ġ�� �ľ� ����.
	private String boardId;				 //board_id 
	private String postTitle;		     //post_title character varying(200)   	   //�Խñ��� ����
	private char   postBlindFlag;		 //post_blind_flag character(1) 		   //ǥ�ÿ���. �̰͵� Ȯ���ؾ� �Ѵ�.
	private String postContents;  	 	 //post_contents text 					   //�Խñ��� ����
	private String postCreateDate; 		 //post_create_date timestamp 			   //������
	private String postUpdateDate; 		 //post_update_date timestamp not null 	   //������
	private char   logicalDelFlag; 	 //logical_del_flag character(1) not null  //������ �÷���(1�̸� ����)
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getBoardId() {
		return boardId;
	}
	public void setBoardId(String boardId) {
		this.boardId = boardId;
	}
	public String getPostTitle() {
		return postTitle;
	}
	public void setPostTitle(String postTitle) {
		this.postTitle = postTitle;
	}
	public char getPostBlindFlag() {
		return postBlindFlag;
	}
	public void setPostBlindFlag(char postBlindFlag) {
		this.postBlindFlag = postBlindFlag;
	}
	public String getPostContents() {
		return postContents;
	}
	public void setPostContents(String postContents) {
		this.postContents = postContents;
	}
	public String getPostCreateDate() {
		return postCreateDate;
	}
	public void setPostCreateDate(String postCreateDate) {
		this.postCreateDate = postCreateDate;
	}
	public String getPostUpdateDate() {
		return postUpdateDate;
	}
	public void setPostUpdateDate(String postUpdateDate) {
		this.postUpdateDate = postUpdateDate;
	}
	public char getLogicalDelFlag() {
		return logicalDelFlag;
	}
	public void setLogicalDelFlag(char logicalDelFlag) {
		this.logicalDelFlag = logicalDelFlag;
	}

	
	//2.POST_MGT //�Խñ۰��� ���̺��� ����	

}
