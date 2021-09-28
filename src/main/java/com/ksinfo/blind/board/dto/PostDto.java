package com.ksinfo.blind.board.dto;

import java.util.List;

public final class PostDto {
	private long userId;
	private final long boardId;
	private final String postTitle;
	private final char postBlindFlag;
	private final List<PostBlock> postContents;

	public PostDto(long boardId, String postTitle, char postBlindFlag, List<PostBlock> postContents) {
		this.boardId = boardId;
		this.postTitle = postTitle;
		this.postBlindFlag = postBlindFlag;
		this.postContents = postContents;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public long getBoardId() {
		return boardId;
	}

	public long getUserId() {
		return userId;
	}

	public String getPostTitle() {
		return postTitle;
	}

	public char getPostBlindFlag() {
		return postBlindFlag;
	}

	public String getPostContents() {
		StringBuilder sb = new StringBuilder().append('[');
		int size = postContents.size();
		if (size > 0) {
			sb.append(postContents.get(0));
		} else {
			return sb.append(']').toString();
		}
		for (int i = 1; i < size; ++i) {
			sb.append(',').append(postContents.get(i));
		}
		return sb.append(']').toString();
	}

	public void escapeDoubleQuote() {
		for (int i = postContents.size() - 1; i > -1; --i) {
			PostBlock postBlock = postContents.get(i);
			if (postBlock instanceof ParagraphBlock) {
				((ParagraphBlock.ParagraphData) postBlock.getData()).escapeDoubleQuote();
			}
		}
	}
}