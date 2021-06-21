package com.ksinfo.blind.search.dto;

public class PostAlignDto {
	//1.POST_MGT //�Խñ۰��� ���̺��� ����
	private String postId;			//(JOIN-1) 	 //post_id bigint GENERATED ALWAYS AS IDENTITY
	private String userId;			//(JOIN-2)	 //user_id bigint 					  	   //�Խñ� �ۼ� ������ id.�����ε尡 �ƴ϶�, �ۼ������� ��ġ�� �ľ� ����.
	private int boardId;						 //board_id 
	private String postTitle;		  		  	 //post_title character varying(200)   	   //�Խñ��� ����
	private char   postBlindFlag;				 //post_blind_flag character(1) 		   //ǥ�ÿ���. �̰͵� Ȯ���ؾ� �Ѵ�.
	private String postContents;  	 			 //post_contents text 					   //�Խñ��� ����
	private String postCreateDate; 		 		 //post_create_date timestamp 			   //������
	private String postUpdateDate; 		 	 	 //post_update_date timestamp not null 	   //������
	private char   logicalDelFlag; 		 		 //logical_del_flag character(1) not null  //������ �÷���(1�̸� ����)

	//2.PostCountInfDto(��ȸ��)
	//(JOIN-1) private int postId;  			//post_id bigint not null
	private String postCountId;		  //post_count_id bigint GENERATED ALWAYS AS IDENTITY
	private String postCount;  		//post_count bigint not null

	//3.USER_MGT //�������� ���̺�
	//(���ļ� �ּ�ó��) private char   logicalDelFlag; 	// logical_del_flag character(1) not null
	//(JOIN-2)private int    userId;				//user_id bigint GENERATED ALWAYS AS IDENTITY		//�ۼ������� ��ġȮ��
	private String userNickName;		// user_nickName character varying(30)
	private String nickNamechangeDate;	// nickName_change_date date not null
	private String companyId;			// company_id bigint


	
	//4.BoardDto //����(����)����
	//(JOIN-1) private int 	boardId;
	private String  boardTopicName;   	 // board_topic_name character varying(30) not null	//������ �̸�
	private String  boardOrder;  	 	 // board_order integer not null					//������ ȭ��ǥ�ü���
	private char    anonymousFlag;  	 // anonymous_flag character(1) not null			//������ �г��� ����ŷ����(1�̸� ����ŷ)
	//(���ļ� �ּ�ó��) private char    logicalDelFlag;  // logical_del_flag character(1) not null			//������ �÷���(1�̸� ����)
	


	private Integer recommendCountOfPosts;			//��õ��(���̺� : POST_RECOMMEND_INF)
	private Integer replyCountOfPosts;				//��ۼ�(�� ����Ʈ�� ��� ī��Ʈ.)	
	
	//���ʿ��Ǵ����� �ּ�ó��
	private String  writerCompany;					//post �ۼ����� �ٹ�ȸ�� ���� ����.
	//private Integer boardTopicCount;				//���Ⱥ� ����Ʈ�� ���� ī��Ʈ(�Ѱ��� ����)
	//private Integer boardTopicCountOfAll;		    //���Ⱥ� ����Ʈ�� �Ѱ��� ī��Ʈ

	public String getPostId() {
		return postId;
	}

	public void setPostId(String postId) {
		this.postId = postId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
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

	public String getUserNickName() {
		return userNickName;
	}

	public void setUserNickName(String userNickName) {
		this.userNickName = userNickName;
	}

	public String getNickNamechangeDate() {
		return nickNamechangeDate;
	}

	public void setNickNamechangeDate(String nickNamechangeDate) {
		this.nickNamechangeDate = nickNamechangeDate;
	}

	public String getCompanyId() {
		return companyId;
	}

	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}

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

	public char getAnonymousFlag() {
		return anonymousFlag;
	}

	public void setAnonymousFlag(char anonymousFlag) {
		this.anonymousFlag = anonymousFlag;
	}

	public Integer getRecommendCountOfPosts() {
		return recommendCountOfPosts;
	}

	public void setRecommendCountOfPosts(Integer recommendCountOfPosts) {
		this.recommendCountOfPosts = recommendCountOfPosts;
	}

	public Integer getReplyCountOfPosts() {
		return replyCountOfPosts;
	}

	public void setReplyCountOfPosts(Integer replyCountOfPosts) {
		this.replyCountOfPosts = replyCountOfPosts;
	}

	public String getWriterCompany() {
		return writerCompany;
	}

	public void setWriterCompany(String writerCompany) {
		this.writerCompany = writerCompany;
	}
	
	
	
}
