package com.ksinfo.blind.alert.dto;

public class ReportReasonDto {
	//관련테이블 : REPORT_REASON_MST

	private int reportReasonId; 				//report_reason_id / 신고사유아이디 
	private String  reportReasonCode;				//report_reason_code / 신고사유코드
	private String reportReasonContents; 		//report_reason_contents / 신고사유내용
	private char logicalDelFlag;				// logical_del_flag 논리삭제플래그(0:미삭제, 1:삭제)
	public int getReportReasonId() {
		return reportReasonId;
	}
	public void setReportReasonId(int reportReasonId) {
		this.reportReasonId = reportReasonId;
	}

	public String getReportReasonCode() {
		return reportReasonCode;
	}
	public void setReportReasonCode(String reportReasonCode) {
		this.reportReasonCode = reportReasonCode;
	}
	public String getReportReasonContents() {
		return reportReasonContents;
	}
	public void setReportReasonContents(String reportReasonContents) {
		this.reportReasonContents = reportReasonContents;
	}
	public char getLogicalDelFlag() {
		return logicalDelFlag;
	}
	public void setLogicalDelFlag(char logicalDelFlag) {
		this.logicalDelFlag = logicalDelFlag;
	}



}
