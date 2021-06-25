package com.ksinfo.blind.manage.dto;

public class CompanySearchDto {
	private char verifyFlag;
	private char closingFlag;
	private String searchTarget;
	private String searchKeyword;

	public CompanySearchDto(char verifyFlag, char closingFlag, String searchTarget, String searchKeyword) {
		switch (verifyFlag) {
			case '0':
			case '1':
			case '2':
				this.verifyFlag = verifyFlag;
				break;
			default:
				this.verifyFlag = '3';
				break;
		}
		switch (closingFlag) {
			case '0':
			case '1':
				this.closingFlag = closingFlag;
				break;
			default:
				this.closingFlag = '2';
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

	public char getClosingFlag() {
		return closingFlag;
	}

	public String getSearchTarget() {
		return searchTarget;
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}
}