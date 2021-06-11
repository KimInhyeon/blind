package com.ksinfo.blind.manage.vo;

public class CompanyVO {
	private long companyID;
	private char verifyFlag;
	private char closingFlag;
	private String companyName;
	private String businessTypeName;
	private String companyAddress;
	private String foundingDate;
	private String workersCount;
	private String companyDomain;
	private String userNickName;
	private String appDate;

	public long getCompanyID() {
		return companyID;
	}

	public void setCompanyID(long companyID) {
		this.companyID = companyID;
	}

	public char getVerifyFlag() {
		return verifyFlag;
	}

	public void setVerifyFlag(char verifyFlag) {
		this.verifyFlag = verifyFlag;
	}

	public char getClosingFlag() {
		return closingFlag;
	}

	public void setClosingFlag(char closingFlag) {
		this.closingFlag = closingFlag;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getBusinessTypeName() {
		return businessTypeName;
	}

	public void setBusinessTypeName(String businessTypeName) {
		this.businessTypeName = businessTypeName;
	}

	public String getCompanyAddress() {
		return companyAddress;
	}

	public void setCompanyAddress(String companyAddress) {
		this.companyAddress = companyAddress;
	}

	public String getFoundingDate() {
		return foundingDate;
	}

	public void setFoundingDate(String foundingDate) {
		this.foundingDate = foundingDate;
	}

	public String getWorkersCount() {
		return workersCount;
	}

	public void setWorkersCount(String workersCount) {
		this.workersCount = workersCount;
	}

	public String getCompanyDomain() {
		return companyDomain;
	}

	public void setCompanyDomain(String companyDomain) {
		this.companyDomain = companyDomain;
	}

	public String getUserNickName() {
		return userNickName;
	}

	public void setUserNickName(String userNickName) {
		this.userNickName = userNickName;
	}

	public String getAppDate() {
		return appDate;
	}

	public void setAppDate(String appDate) {
		this.appDate = appDate;
	}
}