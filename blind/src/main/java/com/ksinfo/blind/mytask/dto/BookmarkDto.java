package com.ksinfo.blind.mytask.dto;

public class BookmarkDto {
	private long boardId; //게시판 아이디
	private String boardTopicname; // 게시판 이름
	private long postId; //게시글 아이디
	private String postTitle; // 게시글 이름
	private String postContents; // 게시글 본문
	private long companyId; //회사 아이디
	private String companyName; //회사 이름
	private String userNickName; // 유저 닉네임
	private String createDate; // 게시글 작성 날짜
	private String postFileUrl; //이미지 파일
	private String postCount; //조회수
	private String recommendCount; //좋아요 수
	private String replyCount; //댓글 수
	private long userId; //유저 아이디
	private long bookmarkId; //북마크 아이디
	private String logicalDelFlag;


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

	public long getPostId() {
		return postId;
	}

	public void setPostId(long postId) {
		this.postId = postId;
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

	public long getCompanyId() {
		return companyId;
	}

	public void setCompanyId(long companyId) {
		this.companyId = companyId;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getUserNickName() {
		return userNickName;
	}

	public void setUserNickName(String userNickName) {
		this.userNickName = userNickName;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getPostFileUrl() {
		return postFileUrl;
	}

	public void setPostFileUrl(String postFileUrl) {
		this.postFileUrl = postFileUrl;
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

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public long getBookmarkId() {
		return bookmarkId;
	}

	public void setBookmarkId(long bookmarkId) {
		this.bookmarkId = bookmarkId;
	}

	public String getLogicalDelFlag() {
		return logicalDelFlag;
	}

	public void setLogicalDelFlag(String logicalDelFlag) {
		this.logicalDelFlag = logicalDelFlag;
	}
}
