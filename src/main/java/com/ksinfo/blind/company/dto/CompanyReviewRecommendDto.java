package com.ksinfo.blind.company.dto;

public final class CompanyReviewRecommendDto {
	private final long userId;
	private final long companyReviewId;

	public CompanyReviewRecommendDto(long userId, long companyReviewId) {
		this.userId = userId;
		this.companyReviewId = companyReviewId;
	}

	public long getUserId() {
		return userId;
	}

	public long getCompanyReviewId() {
		return companyReviewId;
	}
}