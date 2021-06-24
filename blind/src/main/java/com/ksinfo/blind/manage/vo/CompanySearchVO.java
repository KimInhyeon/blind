package com.ksinfo.blind.manage.vo;

public class CompanySearchVO {
	private char verifyFlag;
	private char closingFlag;
	private String searchTarget;
	private String searchKeyword;

	public CompanySearchVO(char verifyFlag, char closingFlag, String searchTarget, String searchKeyword) {
		this.verifyFlag = verifyFlag;
		this.closingFlag = closingFlag;
		this.searchTarget = searchTarget;
		this.searchKeyword = searchKeyword;
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