package com.ksinfo.blind.common.dto;

public final class PostReportDto {
	private long postId;
	private long userId;
	private String reportReasonCode;
	private String reportReasonContent;

	public long getPostId() {
		return postId;
	}

	public void setPostId(long postId) {
		this.postId = postId;
	}

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public String getReportReasonCode() {
		return reportReasonCode;
	}

	public void setReportReasonCode(String reportReasonCode) {
		this.reportReasonCode = reportReasonCode;
	}

	public String getReportReasonContent() {
		return reportReasonContent;
	}

	public void setReportReasonContent(String reportReasonContent) {
		this.reportReasonContent = reportReasonContent;
	}
}