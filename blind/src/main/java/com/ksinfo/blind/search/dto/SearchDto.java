package com.ksinfo.blind.search.dto;


//DTO = VO 
public class SearchDto {
	
	
	//VO역할(SQL 데이터와 동일하게 작성)
	
	//1.BOARD_MGT 토픽(게시판)관리 테이블의 변수
	private String boardTopicName;   	 // board_topic_name character varying(30) not null	//토픽의 이름
	private String boardOrder;  	 	 // board_order integer not null					//토픽의 화면표시순번
	private char   boardAnonymousFlag;   // anonymous_flag character(1) not null			//토픽의 닉네임 마스킹여부(1이면 마스킹)
	private char   boardLogicalDelFlag;  // logical_del_flag character(1) not null			//논리삭제 플래그(1이면 삭제)
	
	
	//2.POST_MGT //게시글관리 테이블의 변수
	private String postUserId;			 //user_id bigint 					  	   //게시글 작성 유저의 id.직접로드가 아니라, 작성유저의 일치를 파악 위함.
	private String postTitle;		     //post_title character varying(200)   	   //게시글의 제목
	private char   postBlindFlag;		 //post_blind_flag character(1) 		   //표시여부. 이것도 확인해야 한다.
	private String postContentText;  	 //post_contents text 					   //게시글의 내용
	private String postCreateDate; 		 //post_create_date timestamp 			   //생성일
	private String postUpdateDate; 		 //post_update_date timestamp not null 	   //갱신일
	private char   postLogicalDelFlag; 	 //logical_del_flag character(1) not null  //논리삭제 플래그(1이면 삭제)
	

	
	//3.USER_MGT //유저관리 테이블
	private String userUserId;				//user_id bigint GENERATED ALWAYS AS IDENTITY		//작성자인지 일치확인
	private String userNickName;			// user_nickName character varying(30)
	private String nickNamechangeDate;	// nickName_change_date date not null
	private String companyId;				// company_id bigint
	private char   userLogicalDelFlag; 	    // logical_del_flag character(1) not null
	

	//4.COMPANY_MGT 기업관리 테이블 생성
	private String companyCompanyId;		//company_id bigint GENERATED ALWAYS AS IDENTITY
	private String companyUserId;			//user_id bigint not null						
	private String companyCompanyName;  	//company_name character varying(50) not null
	private String companyBusinessTypeCode;	// business_type_code character(2)
	private String companyCompanyAddress;	// company_address character varying(200)
	private String companyVerifyFlag;		// verify_flag character(1) not null
	private String companyClosingFlag;		// closing_flag character(1) not null

	
	
	
	//1.BOARD_MGT 토픽(게시판)관리 관련 get/set함수들	
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


	
	//2.POST_MGT //게시글관리 테이블의 변수	
	public String getPostUserId() {
		return postUserId;
	}

	public void setPostUserId(String postUserId) {
		this.postUserId = postUserId;
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

	public String getPostContentText() {
		return postContentText;
	}

	public void setPostContentText(String postContentText) {
		this.postContentText = postContentText;
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

	public char getPostLogicalDelFlag() {
		return postLogicalDelFlag;
	}

	public void setPostLogicalDelFlag(char postLogicalDelFlag) {
		this.postLogicalDelFlag = postLogicalDelFlag;
	}

	
	
	
	//3.USER_MGT //유저관리 테이블	
	public String getUserUserId() {
		return userUserId;
	}

	public void setUserUserId(String userUserId) {
		this.userUserId = userUserId;
	}



	public char getUserLogicalDelFlag() {
		return userLogicalDelFlag;
	}

	public void setUserLogicalDelFlag(char userLogicalDelFlag) {
		this.userLogicalDelFlag = userLogicalDelFlag;
	}

	
	//4.COMPANY_MGT 기업관리 테이블 생성	
	public String getCompanyCompanyId() {
		return companyCompanyId;
	}

	public void setCompanyCompanyId(String companyCompanyId) {
		this.companyCompanyId = companyCompanyId;
	}

	public String getCompanyUserId() {
		return companyUserId;
	}

	public void setCompanyUserId(String companyUserId) {
		this.companyUserId = companyUserId;
	}

	public String getCompanyCompanyName() {
		return companyCompanyName;
	}

	public void setCompanyCompanyName(String companyCompanyName) {
		this.companyCompanyName = companyCompanyName;
	}

	public String getCompanyBusinessTypeCode() {
		return companyBusinessTypeCode;
	}

	public void setCompanyBusinessTypeCode(String companyBusinessTypeCode) {
		this.companyBusinessTypeCode = companyBusinessTypeCode;
	}

	public String getCompanyCompanyAddress() {
		return companyCompanyAddress;
	}

	public void setCompanyCompanyAddress(String companyCompanyAddress) {
		this.companyCompanyAddress = companyCompanyAddress;
	}

	public String getCompanyVerifyFlag() {
		return companyVerifyFlag;
	}

	public void setCompanyVerifyFlag(String companyVerifyFlag) {
		this.companyVerifyFlag = companyVerifyFlag;
	}

	public String getCompanyClosingFlag() {
		return companyClosingFlag;
	}

	public void setCompanyClosingFlag(String companyClosingFlag) {
		this.companyClosingFlag = companyClosingFlag;
	}

	public String getBoardTopicName() {
		return boardTopicName;
	}

	public void setBoardTopicName(String boardTopicName) {
		this.boardTopicName = boardTopicName;
	}
}