package com.ksinfo.blind.board.vo;

public final class PostEditFileVO {
	private final long postFileId;
	private final String postFileOriginName;
	private final long postFileSize;

	public PostEditFileVO(long postFileId, String postFileOriginName, long postFileSize) {
		this.postFileId = postFileId;
		this.postFileOriginName = postFileOriginName;
		this.postFileSize = postFileSize;
	}

	public long getPostFileId() {
		return postFileId;
	}

	public String getPostFileOriginName() {
		return postFileOriginName;
	}

	public long getPostFileSize() {
		return postFileSize;
	}
}