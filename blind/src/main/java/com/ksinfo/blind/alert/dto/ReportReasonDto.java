package com.ksinfo.blind.alert.dto;

public class ReportReasonDto {
	//�������̺� : REPORT_REASON_MST

	private int reportReasonId; 				//report_reason_id / �Ű�������̵� 
	private String  reportReasonCode;				//report_reason_code / �Ű�����ڵ�
	private String reportReasonContents; 		//report_reason_contents / �Ű��������
	private char logicalDelFlag;				// logical_del_flag �������÷���(0:�̻���, 1:����)
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
