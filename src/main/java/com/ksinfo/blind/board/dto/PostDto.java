package com.ksinfo.blind.board.dto;

import java.util.List;

public final class PostDto {
	private long userId;
	private final long boardId;
	private final String title;
	private final char blindFlag;
	private final List<PostBlock> contents;

	public PostDto(long boardId, String title, char blindFlag, List<PostBlock> contents) {
		this.boardId = boardId;
		this.title = title;
		this.blindFlag = blindFlag;
		this.contents = contents;
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

	public String getTitle() {
		return title;
	}

	public char getBlindFlag() {
		return blindFlag;
	}

	public String getContents() {
		StringBuilder sb = new StringBuilder().append('[');
		int size = contents.size();
		if (size > 0) {
			sb.append(contents.get(0));
		} else {
			return sb.append(']').toString();
		}
		for (int i = 1; i < size; ++i) {
			sb.append(',').append(contents.get(i));
		}
		return sb.append(']').toString();
	}

	public void escapeDoubleQuote() {
		for (int i = contents.size() - 1; i > -1; --i) {
			PostBlock postBlock = contents.get(i);
			if (postBlock instanceof ParagraphBlock) {
				((ParagraphBlock.ParagraphData) postBlock.getData()).escapeDoubleQuote();
			}
		}
	}
}