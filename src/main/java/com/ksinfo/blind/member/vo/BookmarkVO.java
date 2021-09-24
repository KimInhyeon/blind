package com.ksinfo.blind.member.vo;

public final class BookmarkVO {
	private final long bookmarkId;
	private final char logicalDelFlag;

	public BookmarkVO(long bookmarkId, char logicalDelFlag) {
		this.bookmarkId = bookmarkId;
		this.logicalDelFlag = logicalDelFlag;
	}

	public long getBookmarkId() {
		return bookmarkId;
	}

	public char getLogicalDelFlag() {
		return logicalDelFlag;
	}
}