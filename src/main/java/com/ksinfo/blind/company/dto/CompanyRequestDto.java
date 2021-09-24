package com.ksinfo.blind.company.dto;

public final class CompanyRequestDto {
	private long userId;
	private final String companyName;
	private final String companyDomain;
	private final String companyHomepage;
	private final String companyExplain;

	public CompanyRequestDto(String companyName, String companyDomain, String companyHomepage, String companyExplain) {
		this.companyName = companyName;
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

	public String getCompanyName() {
		return companyName;
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