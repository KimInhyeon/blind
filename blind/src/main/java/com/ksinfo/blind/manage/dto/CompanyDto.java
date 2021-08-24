package com.ksinfo.blind.manage.dto;

import java.sql.Date;

public final class CompanyDto {
	private long userId;
	private final long companyId;
	private final char verifyFlag;
	private final char closingFlag;
	private final String companyName;
	private final String searchCompanyName;
	private final String businessTypeCode;
	private final Date foundingDate;
	private final String workersCount;
	private final String companyAddress;
	private final String companyDomain;
	private final String companyHomepage;
	private final String companyExplain;

	public CompanyDto(
		long companyId, char verifyFlag, char closingFlag, String companyName,
		String searchCompanyName, String businessTypeCode, Date foundingDate, String workersCount,
		String companyAddress, String companyDomain, String companyHomepage, String companyExplain
	) {
		this.companyId = companyId;
		switch (verifyFlag) {
			case '0':
			case '1':
				this.verifyFlag = verifyFlag;
				break;
			default:
				this.verifyFlag = '2';
				break;
		}
		if (closingFlag == '0') {
			this.closingFlag = '0';
		} else {
			this.closingFlag = '1';
		}
		this.companyName = companyName;
		this.searchCompanyName = searchCompanyName;
		this.businessTypeCode = businessTypeCode;
		this.foundingDate = foundingDate;
		this.workersCount = workersCount;
		this.companyAddress = companyAddress;
		this.companyDomain = companyDomain;
		this.companyHomepage = companyHomepage;
		this.companyExplain = companyExplain;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public long getUserId() {
		return userId;
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

	public Date getFoundingDate() {
		return foundingDate;
	}

	public String getWorkersCount() {
		return workersCount;
	}

	public String getCompanyAddress() {
		return companyAddress;
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
}