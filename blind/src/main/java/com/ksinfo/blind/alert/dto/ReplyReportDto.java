package com.ksinfo.blind.alert.dto;

public class ReplyReportDto {
	private int	replyId; 					//, reply_id bigint not null
	private int	userId;  					//, user_id bigint not null
	private String reportReasonCode;	  	//, report_reason_code character(2) not null
	private String reportReasonContent;	 	//, report_reason_content character varying(400)
	
	public int getReplyId() {
		return replyId;
	}
	public void setReplyId(int replyId) {
		this.replyId = replyId;
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
