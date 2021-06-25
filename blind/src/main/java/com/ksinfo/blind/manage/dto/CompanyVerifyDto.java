package com.ksinfo.blind.manage.dto;

public class CompanyVerifyDto {
	private long userId;
	private long[] companyIdList;
	private char verifyFlag;
	private String reason;

	public CompanyVerifyDto(long[] companyIdList, char verifyFlag, String reason) {
		this.companyIdList = companyIdList;
		if (verifyFlag == '1') {
			this.verifyFlag = '1';
		} else {
			this.verifyFlag = '2';
		}
		this.reason = reason;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public long getUserId() {
		return userId;
	}

	public long[] getCompanyIdList() {
		return companyIdList;
	}

	public char getVerifyFlag() {
		return verifyFlag;
	}

	public String getReason() {
		return reason;
	}
}