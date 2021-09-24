package com.ksinfo.blind.common.dto;

public final class ReplyReportDto {
	private long replyId;
	private long userId;
	private String reportReasonCode;
	private String reportReasonContent;

	public long getReplyId() {
		return replyId;
	}

	public void setReplyId(long replyId) {
		this.replyId = replyId;
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