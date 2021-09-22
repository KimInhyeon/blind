package com.ksinfo.blind.common.dto;

public final class ReviewReportDto {
	private long companyReviewId;
	private long userId;
	private String reportReasonCode;
	private String reportReasonContent;

	public long getCompanyReviewId() {
		return companyReviewId;
	}

	public void setCompanyReviewId(long companyReviewId) {
		this.companyReviewId = companyReviewId;
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