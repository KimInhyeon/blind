package com.ksinfo.blind.manage.vo;

public final class CompanyVO {
	private final long companyId;
	private final char verifyFlag;
	private final char closingFlag;
	private final String companyName;
	private final String searchCompanyName;
	private final String businessTypeCode;
	private final String companyAddress;
	private final String foundingDate;
	private final String workersCount;
	private final String companyDomain;
	private final String companyHomepage;
	private final String companyExplain;
	private final String userNickName;
	private final String appDate;

	public CompanyVO(
		long companyId, char verifyFlag, char closingFlag, String companyName, String searchCompanyName,
		String businessTypeCode, String companyAddress, String foundingDate, String workersCount, String companyDomain,
		String companyHomepage, String companyExplain, String userNickName, String appDate
	) {
		this.companyId = companyId;
		this.verifyFlag = verifyFlag;
		this.closingFlag = closingFlag;
		this.companyName = companyName;
		this.searchCompanyName = searchCompanyName;
		this.businessTypeCode = businessTypeCode;
		this.companyAddress = companyAddress;
		this.foundingDate = foundingDate;
		this.workersCount = workersCount;
		this.companyDomain = companyDomain;
		this.companyHomepage = companyHomepage;
		this.companyExplain = companyExplain;
		this.userNickName = userNickName;
		this.appDate = appDate;
	}

	public long getCompanyId() {
		return companyId;
	}

	public char getVerifyFlag() {
		return verifyFlag;
	}

	public char getClosingFlag() {
		return closingFlag;
	}

	public String getCompanyName() {
		return companyName;
	}

	public String getSearchCompanyName() {
		return searchCompanyName;
	}

	public String getBusinessTypeCode() {
		return businessTypeCode;
	}

	public String getCompanyAddress() {
		return companyAddress;
	}

	public String getFoundingDate() {
		return foundingDate;
	}

	public String getWorkersCount() {
		return workersCount;
	}

	public String getCompanyDomain() {
		return companyDomain;
	}

	public String getCompanyHomepage() {
		return companyHomepage;
	}

	public String getCompanyExplain() {
		return companyExplain;
	}

	public String getUserNickName() {
		return userNickName;
	}

	public String getAppDate() {
		return appDate;
	}
}