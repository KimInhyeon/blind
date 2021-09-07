package com.ksinfo.blind.search.dto;

public class PostDto {
	//2.POST_MGT //게시글관리 테이블의 변수
	private int postId; //post_id bigint GENERATED ALWAYS AS IDENTITY
	private int userId; //user_id bigint //게시글 작성 유저의 id.직접로드가 아니라, 작성유저의 일치를 파악 위함.
	private int boardId; //board_id
	private long companyId; //board_id
	private String postTitle; //post_title character varying(200) //게시글의 제목
	private String postContents; //post_contents text //게시글의 내용
	private String postCreateDate; //post_create_date timestamp //생성일
	private String postUpdateDate; //post_update_date timestamp not null //갱신일
	private String recommendCount; //글의 추천수
	private String replyCount; //글의 댓글수
	private String postCountId; //post_count_id bigint GENERATED ALWAYS AS IDENTITY
	private String postCount; //post_count bigint not null
	private String boardTopicName;
	private String userNickName; // USER_MGT user_nickName character varying(30)
	private String companyName; //포스트를 작성한 유저가 근무하는 회사이름
	private int bookmarkId;
	private int logicalDelFlag; //북마크의 논리삭제 플래그. '0:북마크해제/1:북마크등록'으로 취급하여 jsp에서 북마크표기에 활용.

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

	public long getCompanyId() {
		return companyId;
	}

	public void setCompanyId(long companyId) {
		this.companyId = companyId;
	}

	public String getPostTitle() {
		return postTitle;
	}

	public void setPostTitle(String postTitle) {
		this.postTitle = postTitle;
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

	public int getBookmarkId() {
		return bookmarkId;
	}

	public void setBookmarkId(int bookmarkId) {
		this.bookmarkId = bookmarkId;
	}

	public int getLogicalDelFlag() {
		return logicalDelFlag;
	}

	public void setLogicalDelFlag(int logicalDelFlag) {
		this.logicalDelFlag = logicalDelFlag;
	}
}