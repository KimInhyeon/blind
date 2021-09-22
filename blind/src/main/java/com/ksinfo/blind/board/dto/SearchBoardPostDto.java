package com.ksinfo.blind.board.dto;

public final class SearchBoardPostDto {
	private final long userId;
	private final long boardId;
	private final long postId;

	public SearchBoardPostDto(long userId, long boardId, long postId) {
		this.userId = userId;
		this.boardId = boardId;
		this.postId = postId;
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
}