package com.ksinfo.blind.company.dto;

public final class CompanyPostSearchDto {
	private final long userId;
	private final String companyName;
	private final String searchKeyword;

	public CompanyPostSearchDto(long userId, String companyName, String searchKeyword) {
		this.userId = userId;
		this.companyName = companyName;
		this.searchKeyword = searchKeyword;
	}

	public long getUserId() {
		return userId;
	}

	public String getCompanyName() {
		return companyName;
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}
}