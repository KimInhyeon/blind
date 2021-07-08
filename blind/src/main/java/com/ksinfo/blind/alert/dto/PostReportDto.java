package com.ksinfo.blind.alert.dto;

public class PostReportDto {
	private int postId;						//	, post_id
	private int userId;						//	, user_id
	private String reportReasonCode;			//	, report_reason_code
	private String  reportReasonContent;	//	, report_reason_content
	
	public int getPostId() {
		return postId;
	}
	public void setPostId(int postId) {
		this.postId = postId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
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
