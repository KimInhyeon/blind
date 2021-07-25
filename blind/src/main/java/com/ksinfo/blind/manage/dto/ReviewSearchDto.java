package com.ksinfo.blind.manage.dto;

public final class ReviewSearchDto {
	private final char verifyFlag;
	private final char workingFlag;
	private final String searchTarget;
	private final String searchKeyword;

	public ReviewSearchDto(char verifyFlag, char workingFlag, String searchTarget, String searchKeyword) {
		switch (verifyFlag) {
			case '0':
			case '1':
			case '2':
			case '3':
				this.verifyFlag = verifyFlag;
				break;
			default:
				this.verifyFlag = '0';
				break;
		}
		switch (workingFlag) {
			case '0':
			case '1':
			case '2':
				this.workingFlag = workingFlag;
				break;
			default:
				this.workingFlag = '0';
				break;
		}
		if (searchKeyword == null || searchTarget == null) {
			this.searchTarget = null;
			this.searchKeyword = null;
		} else {
			this.searchTarget = searchTarget;
			this.searchKeyword = searchKeyword;
		}
	}

	public char getVerifyFlag() {
		return verifyFlag;
	}

	public char getWorkingFlag() {
		return workingFlag;
	}

	public String getSearchTarget() {
		return searchTarget;
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}
}