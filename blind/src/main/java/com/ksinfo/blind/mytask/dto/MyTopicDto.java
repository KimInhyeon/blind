package com.ksinfo.blind.mytask.dto;

public class MyTopicDto { //
	private int mytopicType;
	private String userNickName; // 유저 닉네임
	private String boardTopicname; // 게시판 이름
	private String postId; //게시글 아이디
	private String postTitle; // 게시글 이름
	private String createDate; // 게시글 작성 날짜
	private String postReportNickName; // 게시글 신고 닉네임
	private long companyId;
	private String companyName;
	private long reportedCount;

	
	
	public int getMytopicType() {
		return mytopicType;
	}
	public void setMytopicType(int mytopicType) {
		this.mytopicType = mytopicType;
	}
	public String getUserNickName() {
		return userNickName;
	}
	public void setUserNickName(String userNickName) {
		this.userNickName = userNickName;
	}
	public String getBoardTopicname() {
		return boardTopicname;
	}
	public void setBoardTopicname(String boardTopicname) {
		this.boardTopicname = boardTopicname;
	}

	public String getPostId() {
		return postId;
	}

	public void setPostId(String postId) {
		this.postId = postId;
	}

	public String getPostTitle() {
		return postTitle;
	}
	public void setPostTitle(String postTitle) {
		this.postTitle = postTitle;
	}
	public String getcreateDate() {
		return createDate;
	}
	public void setcreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getPostReportNickName() {
		return postReportNickName;
	}
	public void setPostReportNickName(String postReportNickName) {
		this.postReportNickName = postReportNickName;
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
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public long getReportedCount() {
		return reportedCount;
	}
	public void setReportedCount(long reportedCount) {
		this.reportedCount = reportedCount;
	}
	
	

}
