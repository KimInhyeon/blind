package com.ksinfo.blind.manage.dto;

import java.sql.Date;

public class CompanyDto {
	private long userId;
	private long companyId;
	private char verifyFlag;
	private char closingFlag;
	private String companyName;
	private String businessTypeCode;
	private Date foundingDate;
	private String workersCount;
	private String companyAddress;
	private String companyDomain;
	private String companyHomepage;
	private String companyExplain;

	public CompanyDto(long companyId, char verifyFlag, char closingFlag,
		String companyName, String businessTypeCode, Date foundingDate, String workersCount,
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