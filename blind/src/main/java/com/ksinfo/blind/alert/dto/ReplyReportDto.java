package com.ksinfo.blind.alert.dto;

public class ReplyReportDto {
	private int	replyReportId;  			//reply_report_id bigint GENERATED ALWAYS AS IDENTITY
	private int	replyId; 					//, reply_id bigint not null
	private int	userId;  					//, user_id bigint not null
	private String replyReportDate;	  		//, reply_report_date timestamp not null
	private String reportReasonCode;	  	//, report_reason_code character(2) not null
	private String reportReasonContent;	 	//, report_reason_content character varying(400)
	private char verifyFlag; 				//, verify_flag character(1) not null
	private char completeFlag; 				//, complete_flag character(1) not null
	private String rejectReason;		  	//, reject_reason character varying(100)
	private int  recCreateUserId;			//, rec_create_user_id bigint not null
	private String recCreateDate;		 	//, rec_create_date timestamp not null
	private int  recUpdateUserId;		 	//, rec_update_user_id bigint not null
	private String recUpdateDate;		 	//, rec_update_date timestamp not null
	private char  logicalDelFlag;			//, logical_del_flag character(1) not null
	

	public int getReplyReportId() {
		return replyReportId;
	}
	public void setReplyReportId(int replyReportId) {
		this.replyReportId = replyReportId;
	}
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
	public String getReplyReportDate() {
		return replyReportDate;
	}
	public void setReplyReportDate(String replyReportDate) {
		this.replyReportDate = replyReportDate;
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
	public char getVerifyFlag() {
		return verifyFlag;
	}
	public void setVerifyFlag(char verifyFlag) {
		this.verifyFlag = verifyFlag;
	}
	public char getCompleteFlag() {
		return completeFlag;
	}
	public void setCompleteFlag(char completeFlag) {
		this.completeFlag = completeFlag;
	}
	public String getRejectReason() {
		return rejectReason;
	}
	public void setRejectReason(String rejectReason) {
		this.rejectReason = rejectReason;
	}
	public int getRecCreateUserId() {
		return recCreateUserId;
	}
	public void setRecCreateUserId(int recCreateUserId) {
		this.recCreateUserId = recCreateUserId;
	}
	public String getRecCreateDate() {
		return recCreateDate;
	}
	public void setRecCreateDate(String recCreateDate) {
		this.recCreateDate = recCreateDate;
	}
	public int getRecUpdateUserId() {
		return recUpdateUserId;
	}
	public void setRecUpdateUserId(int recUpdateUserId) {
		this.recUpdateUserId = recUpdateUserId;
	}
	public String getRecUpdateDate() {
		return recUpdateDate;
	}
	public void setRecUpdateDate(String recUpdateDate) {
		this.recUpdateDate = recUpdateDate;
	}
	public char getLogicalDelFlag() {
		return logicalDelFlag;
	}
	public void setLogicalDelFlag(char logicalDelFlag) {
		this.logicalDelFlag = logicalDelFlag;
	}
	
}
