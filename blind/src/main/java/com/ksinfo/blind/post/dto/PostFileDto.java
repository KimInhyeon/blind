package com.ksinfo.blind.post.dto;

import org.springframework.web.multipart.MultipartFile;

public final class PostFileDto {
	private final long userId;
	private final long postId;
	private String postFileUrl;
	private String postFileOriginName;
	private long postFileSize;

	public PostFileDto(long userId, long postId) {
		this.userId = userId;
		this.postId = postId;
	}

	public void setPostFileInfo(String fileUrl, MultipartFile file) {
		postFileUrl = fileUrl;
		postFileOriginName = file.getOriginalFilename();
		postFileSize = file.getSize();
	}

	public long getUserId() {
		return userId;
	}

	public long getPostId() {
		return postId;
	}

	public String getPostFileUrl() {
		return postFileUrl;
	}

	public String getPostFileOriginName() {
		return postFileOriginName;
	}

	public long getPostFileSize() {
		return postFileSize;
	}
}