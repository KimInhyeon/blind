package com.ksinfo.blind.common.dto;

public class CommonPostDto { //POST_MGT 참조
	private long postId; //게시글 아이디
	private long boardId; //게시판 아이디
	private String boardTopicname; //게시판 이름
	private long userId; // 게시글 작성 유저 아이디
	private String postTitle; // 게시글 타이틀
	private String postCreateDate; //게시글 작성 날짜
	private String postCount; //조회수
	private long recordCount;
	private String recommendCount; //좋아요 수
	private String replyCount; //댓글 수
	
	public long getPostId() {
		return postId;
	}
	public void setPostId(long postId) {
		this.postId = postId;
	}
	
	public long getBoardId() {
		return boardId;
	}
	public void setBoardId(long boardId) {
		this.boardId = boardId;
	}
	public String getBoardTopicname() {
		return boardTopicname;
	}
	public void setBoardTopicname(String boardTopicname) {
		this.boardTopicname = boardTopicname;
	}
	public long getUserId() {
		return userId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}

	public String getPostTitle() {
		return postTitle;
	}
	public void setPostTitle(String postTitle) {
		this.postTitle = postTitle;
	}

	public String getPostCreateDate() {
		return postCreateDate;
	}
	public void setPostCreateDate(String postCreateDate) {
		this.postCreateDate = postCreateDate;
	}
	public String getPostCount() {
		return postCount;
	}
	public void setPostCount(String postCount) {
		this.postCount = postCount;
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

	public long getRecordCount() {
		return recordCount;
	}
	public void setRecordCount(long recordCount) {
		this.recordCount = recordCount;
	}
	
	
	
	
	
	
}
