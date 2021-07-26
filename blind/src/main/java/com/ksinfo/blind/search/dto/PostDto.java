package com.ksinfo.blind.search.dto;

public class PostDto {
	
	//2.POST_MGT //�Խñ۰��� ���̺��� ����
	private int postId;			 	 //post_id bigint GENERATED ALWAYS AS IDENTITY
	private int userId;				 //user_id bigint 					  	   //�Խñ� �ۼ� ������ id.�����ε尡 �ƴ϶�, �ۼ������� ��ġ�� �ľ� ����.
	private int boardId;				 //board_id
	private long companyId;				 //board_id 
	private String postTitle;		     //post_title character varying(200)   	   //�Խñ��� ����
	private char   postBlindFlag;		 //post_blind_flag character(1) 		   //ǥ�ÿ���. �̰͵� Ȯ���ؾ� �Ѵ�.
	private String postContents;  	 	 //post_contents text 					   //�Խñ��� ����
	private String postCreateDate; 		 //post_create_date timestamp 			   //������
	private String postUpdateDate; 		 //post_update_date timestamp not null 	   //������
	private char   logicalDelFlag; 	 //logical_del_flag character(1) not null  //������ �÷���(1�̸� ����)
	private String recommendCount;   //���� ��õ��
	private String replyCount;       //���� ��ۼ�
	
	//Ÿ Dto �����ۼ�
	//PostCountInfDto�� ����
	private String postCountId;		  //post_count_id bigint GENERATED ALWAYS AS IDENTITY
	private String postCount;  		//post_count bigint not null		
	//BOARD_MGT ����(�Խ���)���� ���̺��� ����
	private String  boardTopicName; 
	//USER_MGT ���� ���̺��� ����
	private String userNickName;		// user_nickName character varying(30)
	//�����߰�
	private String companyName;		//����Ʈ�� �ۼ��� ������ �ٹ��ϴ� ȸ���̸�
	
	
	public int getPostId() {
		return postId;
	}
	public void setPostId(int postId) {
		this.postId = postId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getBoardId() {
		return boardId;
	}
	public void setBoardId(int boardId) {
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
	public String getRecommendCount() {
		return recommendCount;
	}
	public void setRecommendCount(String recommendCount) {
		this.recommendCount = recommendCount;
	}
	public String getReplyCount() {
		return replyCount;
	}
	public void setReplyCount(String replyCount) {
		this.replyCount = replyCount;
	}
	public String getPostCountId() {
		return postCountId;
	}
	public void setPostCountId(String postCountId) {
		this.postCountId = postCountId;
	}
	public String getPostCount() {
		return postCount;
	}
	public void setPostCount(String postCount) {
		this.postCount = postCount;
	}
	public String getBoardTopicName() {
		return boardTopicName;
	}
	public void setBoardTopicName(String boardTopicName) {
		this.boardTopicName = boardTopicName;
	}
	public String getUserNickName() {
		return userNickName;
	}
	public void setUserNickName(String userNickName) {
		this.userNickName = userNickName;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public long getCompanyId() {
		return companyId;
	}
	public void setCompanyId(long companyId) {
		this.companyId = companyId;
	}
	
	// get/set �������


}
