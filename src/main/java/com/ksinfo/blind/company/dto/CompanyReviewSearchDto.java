package com.ksinfo.blind.company.dto;

public final class CompanyReviewSearchDto {
	private long userId;
	private final long companyId;

	public CompanyReviewSearchDto(long userId, long companyId) {
		this.userId = userId;
		this.companyId = companyId;
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
}