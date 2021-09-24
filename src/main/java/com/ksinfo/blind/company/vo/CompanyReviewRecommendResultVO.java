package com.ksinfo.blind.company.vo;

public final class CompanyReviewRecommendResultVO {
	private final int helpfulCount;
	private final int helpful;

	public CompanyReviewRecommendResultVO(int helpfulCount, int helpful) {
		this.helpfulCount = helpfulCount;
		this.helpful = helpful;
	}

	public int getHelpfulCount() {
		return helpfulCount;
	}

	public int getHelpful() {
		return helpful;
	}
}