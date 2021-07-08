package com.ksinfo.blind.alert.dto;

public class ReportReasonDto {

    private int reportReasonId;                 
    private String  reportReasonCode;           
    private String reportReasonContents;        
    private char logicalDelFlag;                
    private String reportScreenCode;
    
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
	public String getReportScreenCode() {
		return reportScreenCode;
	}
	public void setReportScreenCode(String reportScreenCode) {
		this.reportScreenCode = reportScreenCode;
	}            
}
