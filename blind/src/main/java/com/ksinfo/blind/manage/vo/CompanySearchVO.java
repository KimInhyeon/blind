package com.ksinfo.blind.manage.vo;

public class CompanySearchVO {
	private byte verifyFlag;
	private byte closingFlag;
	private String searchTarget;
	private String searchKeyword;

	public CompanySearchVO(byte verifyFlag, byte closingFlag, String searchTarget, String searchKeyword) {
		if (verifyFlag > 3 || verifyFlag < 0) {
			verifyFlag = 0;
		}
		this.verifyFlag = verifyFlag;
		if (closingFlag > 2 || closingFlag < 0) {
			closingFlag = 0;
		}
		this.closingFlag = closingFlag;
		this.searchTarget = searchTarget == null ? "" : searchTarget;
		this.searchKeyword = searchKeyword == null ? "" : searchKeyword;
	}
}