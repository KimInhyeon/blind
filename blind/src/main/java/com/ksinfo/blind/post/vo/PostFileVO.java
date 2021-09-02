package com.ksinfo.blind.post.vo;

public final class PostFileVO {
	private final long postFileId;
	private final String postFileUrl;

	public PostFileVO(long postFileId, String postFileUrl) {
		this.postFileId = postFileId;
		this.postFileUrl = postFileUrl;
	}

	public long getPostFileId() {
		return postFileId;
	}

	public String getPostFileUrl() {
		return postFileUrl;
	}
}