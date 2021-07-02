package com.ksinfo.blind.alert.dto;

public class PostReportDto {
	private int postReportId;				//	post_report_id
	private int postId;						//	, post_id
	private int userId;						//	, user_id
	private String postReportDate;			//	, post_report_date
	private String reportReasonCode;			//	, report_reason_code
	private String  reportReasonContent;	//	, report_reason_content
	private char verifyFlag;				//	, verify_flag
	private char  completeFlag;				//	, complete_flag
	private String rejectReason;			//  , reject_reason character varying(100)
	private int  recCreateUserId;			//	, rec_create_user_id
	private String recCreateDate;			//	, rec_create_date
	private int  recUpdateUserId;			//	, rec_update_user_id
	private String recUpdateDate;			//	, rec_update_date
	private char  logical_del_flag;			//	, logical_del_flag
	
	
	
	public String getRejectReason() {
		return rejectReason;
	}
	public void setRejectReason(String rejectReason) {
		this.rejectReason = rejectReason;
	}
	public int getPostReportId() {
		return postReportId;
	}
	public void setPostReportId(int postReportId) {
		this.postReportId = postReportId;
	}
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
	public String getPostReportDate() {
		return postReportDate;
	}
	public void setPostReportDate(String postReportDate) {
		this.postReportDate = postReportDate;
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
	public char getLogical_del_flag() {
		return logical_del_flag;
	}
	public void setLogical_del_flag(char logical_del_flag) {
		this.logical_del_flag = logical_del_flag;
	}
		
		
	
}
