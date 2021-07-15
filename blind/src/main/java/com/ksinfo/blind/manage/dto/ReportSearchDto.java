package com.ksinfo.blind.manage.dto;

public class ReportSearchDto {
	private char verifyFlag;
	private char completeFlag;
	private String searchTarget;
	private String searchKeyword;

	public ReportSearchDto(char verifyFlag, String searchTarget, String searchKeyword) {
		switch (verifyFlag) {
			case '1':
				this.verifyFlag = '1';
				completeFlag = '1';
				break;
			case '2':
				this.verifyFlag = '0';
				completeFlag = '1';
				break;
			case '3':
				this.verifyFlag = '2';
				completeFlag = '2';
				break;
			case '0':
			default:
				this.verifyFlag = '2';
				completeFlag = '0';
				break;
		}
		if (searchKeyword != null && searchTarget != null) {
			this.searchTarget = searchTarget;
			this.searchKeyword = searchKeyword;
		}
	}

	public char getVerifyFlag() {
		return verifyFlag;
	}

	public char getCompleteFlag() {
		return completeFlag;
	}

	public String getSearchTarget() {
		return searchTarget;
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}
}