package com.ksinfo.blind.common.dto;

public final class SearchPostDto {
	private final long userId;
	private final long boardId;
	private final long postId;
	private final String searchKeyword;
	private final String sort;

	public SearchPostDto(long userId, long boardId, long postId, String searchKeyword, String sort) {
		this.userId = userId;
		this.boardId = boardId;
		this.postId = postId;
		this.searchKeyword = searchKeyword;
		this.sort = sort;
	}

	public long getUserId() {
		return userId;
	}

	public long getBoardId() {
		return boardId;
	}

	public long getPostId() {
		return postId;
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}

	public String getSort() {
		return sort;
	}
}