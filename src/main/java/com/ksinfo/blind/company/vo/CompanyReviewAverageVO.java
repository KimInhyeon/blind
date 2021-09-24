package com.ksinfo.blind.company.vo;

public final class CompanyReviewAverageVO {
	private final float careerPoint;
	private final float workLifeBalancePoint;
	private final float companyCulturePoint;
	private final float payPoint;
	private final float headPoint;

	public CompanyReviewAverageVO(
		float careerPoint, float workLifeBalancePoint, float companyCulturePoint, float payPoint, float headPoint
	) {
		this.careerPoint = careerPoint;
		this.workLifeBalancePoint = workLifeBalancePoint;
		this.companyCulturePoint = companyCulturePoint;
		this.payPoint = payPoint;
		this.headPoint = headPoint;
	}

	public float getCareerPoint() {
		return careerPoint;
	}

	public float getWorkLifeBalancePoint() {
		return workLifeBalancePoint;
	}

	public float getCompanyCulturePoint() {
		return companyCulturePoint;
	}

	public float getPayPoint() {
		return payPoint;
	}

	public float getHeadPoint() {
		return headPoint;
	}
}