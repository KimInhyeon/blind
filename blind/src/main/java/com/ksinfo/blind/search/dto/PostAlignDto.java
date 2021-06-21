package com.ksinfo.blind.search.dto;

public class PostAlignDto {
	//1.POST_MGT //게시글관리 테이블의 변수
	private String postId;			//(JOIN-1) 	 //post_id bigint GENERATED ALWAYS AS IDENTITY
	private String userId;			//(JOIN-2)	 //user_id bigint 					  	   //게시글 작성 유저의 id.직접로드가 아니라, 작성유저의 일치를 파악 위함.
	private int boardId;						 //board_id 
	private String postTitle;		  		  	 //post_title character varying(200)   	   //게시글의 제목
	private char   postBlindFlag;				 //post_blind_flag character(1) 		   //표시여부. 이것도 확인해야 한다.
	private String postContents;  	 			 //post_contents text 					   //게시글의 내용
	private String postCreateDate; 		 		 //post_create_date timestamp 			   //생성일
	private String postUpdateDate; 		 	 	 //post_update_date timestamp not null 	   //갱신일
	private char   logicalDelFlag; 		 		 //logical_del_flag character(1) not null  //논리삭제 플래그(1이면 삭제)

	//2.PostCountInfDto(조회수)
	//(JOIN-1) private int postId;  			//post_id bigint not null
	private String postCountId;		  //post_count_id bigint GENERATED ALWAYS AS IDENTITY
	private String postCount;  		//post_count bigint not null

	//3.USER_MGT //유저관리 테이블
	//(겹쳐서 주석처리) private char   logicalDelFlag; 	// logical_del_flag character(1) not null
	//(JOIN-2)private int    userId;				//user_id bigint GENERATED ALWAYS AS IDENTITY		//작성자인지 일치확인
	private String userNickName;		// user_nickName character varying(30)
	private String nickNamechangeDate;	// nickName_change_date date not null
	private String companyId;			// company_id bigint


	
	//4.BoardDto //토픽(보드)관리
	//(JOIN-1) private int 	boardId;
	private String  boardTopicName;   	 // board_topic_name character varying(30) not null	//토픽의 이름
	private String  boardOrder;  	 	 // board_order integer not null					//토픽의 화면표시순번
	private char    anonymousFlag;  	 // anonymous_flag character(1) not null			//토픽의 닉네임 마스킹여부(1이면 마스킹)
	//(겹쳐서 주석처리) private char    logicalDelFlag;  // logical_del_flag character(1) not null			//논리삭제 플래그(1이면 삭제)
	


	private Integer recommendCountOfPosts;			//추천수(테이블 : POST_RECOMMEND_INF)
	private Integer replyCountOfPosts;				//댓글수(각 포스트별 댓글 카운트.)	
	
	//불필요판단으로 주석처리
	private String  writerCompany;					//post 작성자의 근무회사 정보 저장.
	//private Integer boardTopicCount;				//토픽별 포스트의 갯수 카운트(총갯수 제외)
	//private Integer boardTopicCountOfAll;		    //토픽별 포스트의 총갯수 카운트

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
