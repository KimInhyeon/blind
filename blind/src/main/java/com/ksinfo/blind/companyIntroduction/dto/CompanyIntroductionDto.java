package com.ksinfo.blind.companyIntroduction.dto;

public class CompanyIntroductionDto {
	
	private long companyId;
	private long userId;
	private String companyName;
	private String businessTypeCode;
	private String businessTypeName;
	private String companyAddress;
	private java.util.Date foundingDate;
	private String workersCount;
	private java.util.Date appDate;
	private String companyDomain;
	private String companyHomepage;
	private String companyExplain;
	private char verifyFlag;
	private char closingFlag;
	private float realAllPoint;
	public float getRealAllPoint() {
		return realAllPoint;
	}
	public void setRealAllPoint(float realAllPoint) {
		this.realAllPoint = realAllPoint;
	}
	public long getCompanyId() {
		return companyId;
	}
	public void setCompanyId(long companyId) {
		this.companyId = companyId;
	}
	public long getUserId() {
		return userId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
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
	public java.util.Date getFoundingDate() {
		return foundingDate;
	}
	public void setFoundingDate(java.util.Date foundingDate) {
		this.foundingDate = foundingDate;
	}
	public String getWorkersCount() {
		return workersCount;
	}
	public void setWorkersCount(String workersCount) {
		this.workersCount = workersCount;
	}
	public java.util.Date getAppDate() {
		return appDate;
	}
	public void setAppDate(java.util.Date appDate) {
		this.appDate = appDate;
	}
	public String getCompanyDomain() {
		return companyDomain;
	}
	public void setCompanyDomain(String companyDomain) {
		this.companyDomain = companyDomain;
	}
	public String getCompanyHomepage() {
		return companyHomepage;
	}
	public void setCompanyHomepage(String companyHomepage) {
		this.companyHomepage = companyHomepage;
	}
	public String getCompanyExplain() {
		return companyExplain;
	}
	public void setCompanyExplain(String companyExplain) {
		this.companyExplain = companyExplain;
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
}
