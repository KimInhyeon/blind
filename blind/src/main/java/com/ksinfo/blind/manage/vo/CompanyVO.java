package com.ksinfo.blind.manage.vo;

public class CompanyVO {
	private long companyID;
	private byte verifyFlag;
	private byte closingFlag;
	private String companyName;
	private String businessTypeCode;
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

	public byte getVerifyFlag() {
		return verifyFlag;
	}

	public void setVerifyFlag(byte verifyFlag) {
		this.verifyFlag = verifyFlag;
	}

	public byte getClosingFlag() {
		return closingFlag;
	}

	public void setClosingFlag(byte closingFlag) {
		this.closingFlag = closingFlag;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getBusinessTypeCode() {
		return businessTypeCode;
	}

	public void setBusinessTypeCode(String businessTypeCode) {
		this.businessTypeCode = businessTypeCode;
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