package com.ksinfo.blind.search.dto;

public class BookmarkDto {
	private int bookmarkId;				//bookmark_id bigint GENERATED ALWAYS AS IDENTITY
	private int postId;					//, post_id bigint not null
	private int userId;		 			//, user_id bigint not null
	private String bookmarkCreateDate;	//, bookmark_create_date timestamp not null
	private String bookmarkUpdateDate; 	//, bookmark_update_date timestamp not null
	private char logicalDelFlag;		//, logical_del_flag character(1) not null

	public int getBookmarkId() {
		return bookmarkId;
	}
	public void setBookmarkId(int bookmarkId) {
		this.bookmarkId = bookmarkId;
	}
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
	public String getBookmarkCreateDate() {
		return bookmarkCreateDate;
	}
	public void setBookmarkCreateDate(String bookmarkCreateDate) {
		this.bookmarkCreateDate = bookmarkCreateDate;
	}
	public String getBookmarkUpdateDate() {
		return bookmarkUpdateDate;
	}
	public void setBookmarkUpdateDate(String bookmarkUpdateDate) {
		this.bookmarkUpdateDate = bookmarkUpdateDate;
	}
	public char getLogicalDelFlag() {
		return logicalDelFlag;
	}
	public void setLogicalDelFlag(char logicalDelFlag) {
		this.logicalDelFlag = logicalDelFlag;
	}

}
